import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:InventoryWise/utils/global.dart';

import 'http.dart';

enum ApiType { defaultApi, dioApi }

class ApiResponseInjector {
  // SINGLETON LOGIC
  static final _instance = ApiResponseInjector._internal();
  ApiResponseInjector._internal();

  factory ApiResponseInjector() => _instance;

  Future<HttpWrapper?> httpDataSource(ApiType _apiType) async {
    switch (_apiType) {
      case ApiType.defaultApi:
        return await HttpWrapper.create(
            _apiType.toString(), DefaultV2ApiResponseHandler());
      case ApiType.dioApi:
        return await HttpWrapper.create(
            _apiType.toString(), DioApiResponseHandler());
      default:
        throw Exception("Should have a response type");
    }
  }
}

class MappedResponse<T> {
  int? code;
  bool? success;
  dynamic content;
  String? message;
  String? errorCode;

  MappedResponse(
      {this.code,
      this.content,
      this.message,
      this.success,
      this.errorCode = ''});
}

abstract class ApiResponseHandler {
  Future<Map<String, String>> httpheaders(
      String? token, String contentType, String? userID);
  MappedResponse processResponse(http.Response? response);
  MappedResponse processDioResponse(Response response);
}

class DefaultV2ApiResponseHandler implements ApiResponseHandler {
  Map<String, String>? _appDeviceInfo;

  @override
  Future<Map<String, String>> httpheaders(
      String? token, String contentType, String? userID) async {
    if (_appDeviceInfo == null) {}

    Map<String, String> headers = {};
    // _appDeviceInfo.forEach((key, value) {
    //   headers[key] = value;
    // });
    // var date = DateTime.now().toString();
    // headers['RequestDateTime'] = date;
    // headers['X-Api-token'] = GlobalConstants.apiToken;
    // headers['locale'] = LocalizationService.locale.languageCode;
    // headers['x-forwarded-proto'] = "https";
    headers[HttpHeaders.contentTypeHeader] = contentType;

    // if (token != null) headers['cookies'] = 'token=$token';

    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = token; //'Basic $token';
    }
    if (userID != null) {
      headers['USER_ID'] = userID;
    }
    String? ipAddress = authenticator.getIpAddress();
    if (ipAddress != null) {
      headers['IP-ADDRESS'] = ipAddress;
    }

    headers["x-api-key"] = "abc123!";
    return headers;
  }

  @override
  MappedResponse<dynamic> processResponse(http.Response? response) {
    if (!kReleaseMode) {
      log(response!.statusCode.toString());
      log(response.body.toString());
    }

    // if (response!.headers['content-type']!.contains("text/html")) {
    //   return MappedResponse<dynamic>(
    //       code: response.statusCode,
    //       success: true,
    //       message: 'SUCCESS',
    //       content: response.body);
    // }

    if (response!.statusCode >= 500) {
      if (response.body != (null)) {
        var msg = _extractErrorMessage(json.decode(response.body));

        throw HttpCustomException(code: response.statusCode, message: msg);
      } else {
        throw HttpCustomException(
            code: response.statusCode, message: "Unable to process request");
      }
    } else if (response.statusCode == 204) {
      return MappedResponse<dynamic>(
          code: response.statusCode,
          success: true,
          message: 'SUCCESS',
          content: {});
    } else if (response.statusCode == 403) {
      throw UnauthorizedAccessException(message: response.reasonPhrase!);
      // return MappedResponse<dynamic>(
      //     code: response.statusCode,
      //     success: false,
      //     message: 'SUCCESS',
      //     content: {});
    }

    // if (response.statusCode == 200 &&
    //     response.headers['content-type'] == 'text/plain; charset=utf-8') {
    //   return MappedResponse<dynamic>(
    //       code: response.statusCode,
    //       success: true,
    //       message: "SUCCESS",
    //       content: response.body);
    // }
    if (!((response.statusCode < 200) ||
        (response.statusCode >= 300) ||
        (response.body == (null)))) {
      var body = response.body != (null) && response.body.isNotEmpty
          ? json.decode(response.body)
          : response.reasonPhrase;
      return MappedResponse<dynamic>(
          code: response.statusCode,
          success: true,
          message: "SUCCESS",
          content: body);
    } else {
      var body = json.decode(response.body);
      var message = _extractErrorMessage(body);
      var errorCode = _extractErrorCode(body);

      return MappedResponse<dynamic>(
          code: response.statusCode,
          success: false,
          message: message,
          content: body,
          errorCode: errorCode);
    }
  }

  String? _extractErrorCode(body) {
    String? errorCode = '';
    if (body['response'] != null) {
      if (body['response']['code'] != null) {
        errorCode = body['response']['code'].toString();
      }
    } else if (body['responseCode'] != null) {
      errorCode = body['responseCode'];
    }

    return errorCode;
  }

  String? _extractErrorMessage(body) {
    String? errorMessage = "Failed to process request";
    if (body['msg'] != null) {
      errorMessage = body['msg'];
    } else if (body['errors'] != null) {
      var keys = body['errors'].keys.toList();
      List? values = body['errors'].values.toList();
      if (body["title"].toString().isNotEmpty) {
        if (values!.isNotEmpty) errorMessage = values[0].first.toString();
      } else {
        errorMessage = '${keys[0]}: ${body["title"]}';
      }
    } else if (body['response'] != null) {
      if (body['response']['Message'] != null) {
        errorMessage = body['response']['Message'];
      } else if (body['response']['message'] != null) {
        errorMessage = body['response']['message'];
      }
    } else if (body['errorMessage'] != null) {
      errorMessage = body['errorMessage'];
    } else if (body['error_description'] != null) {
      errorMessage = body['error_description'];
    } else if (body['message'] != null) {
      errorMessage = body['message'];
    } else if (body['Message'] != null) {
      errorMessage = body['Message'];
    } else if (body['errorCategory'] != null) {
      errorMessage = body['errorCategory'];
    } else if (body['errorDescription'] != null) {
      errorMessage = body['errorDescription'];
    } else if (body['error'] != null) {
      errorMessage = body['error'];
    } else if (body['responseDesc'] != null) {
      errorMessage = body['responseDesc'];
    }
    return errorMessage;
  }

  @override
  MappedResponse processDioResponse(Response response) {
    throw UnimplementedError();
  }
}

class DioApiResponseHandler implements ApiResponseHandler {
  Map<String, String>? _appDeviceInfo;
  @override
  Future<Map<String, String>> httpheaders(
      String? token, String contentType, String? userID) async {
    if (_appDeviceInfo == null) {}

    Map<String, String> headers = {};
    // _appDeviceInfo!.forEach((key, value) {
    //   headers[key] = value;
    // });
    // var date = DateTime.now().toString();
    // headers['RequestDateTime'] = date;
    // headers['MobileSdk'] = 'Flutter';
    // headers['locale'] = LocalizationService.locale.languageCode;
    headers[HttpHeaders.contentTypeHeader] = contentType;
    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Basic $token';
    }
    headers["x-api-key"] = "abc123!";
    return headers;
  }

  @override
  MappedResponse<dynamic> processDioResponse(Response response) {
    try {
      if (!kReleaseMode) {
        log(response.statusCode.toString());
        log(response.data);
      }
      if (!((response.statusCode! < 200) ||
          (response.statusCode! >= 300) ||
          (response.data == null))) {
        var body = response.data != null && response.data.isNotEmpty
            ? response.data
            : response.statusCode;
        return MappedResponse<dynamic>(
            code: response.statusCode,
            success: true,
            message: "SUCCESS",
            content: body);
      } else {
        var body = json.decode(response.data);
        var message = _extractErrorMessage(body);

        return MappedResponse<dynamic>(
            code: response.statusCode,
            success: false,
            message: message,
            content: body);
      }
    } catch (e) {
      // print(e);
      log(e.toString());
      rethrow;
    }
  }

  String? _extractErrorMessage(body) {
    String? errorMessage = "Failed to process request";
    if (body['errors'] != null) {
      var keys = body['errors'].keys.toList();
      List? values = body['errors'].values.toList();
      if (body["title"].toString().isNotEmpty) {
        if (values!.isNotEmpty) errorMessage = values[0].first.toString();
      } else {
        errorMessage = '${keys[0]}: ${body["title"]}';
      }
    } else if (body['response'] != null) {
      if (body['response']['Message'] != null) {
        errorMessage = body['response']['Message'];
      } else if (body['response']['message'] != null) {
        errorMessage = body['response']['message'];
      }
    } else if (body['error'] != null) {
      if (body['error'].toString().isNotEmpty) {
        if (body['error']['message'] != null) {
          if (body['error']['message'].toString().isNotEmpty) {
            errorMessage = body['error']['message'];
          }
        }
        // errorMessage = body['error']['message'];
        // cache.errorCode =
        //     cache.isOmno || cache.isRegisterWallet ? body['error']['code'] : '';
      }
    } else if (body['error_description'] != null) {
      errorMessage = body['error_description'];
    } else if (body['message'] != null) {
      if (body['message'].toString().isNotEmpty) errorMessage = body['message'];
    } else if (body['errorCategory'] != null) {
      if (body['errorCategory'].toString().isNotEmpty) {
        errorMessage = body['errorCategory'];
      }
    } else if (body['errorDescription'] != null) {
      if (body['errorDescription'].toString().isNotEmpty) {
        errorMessage = body['errorDescription'];
      }
    }
    return errorMessage;
  }

  @override
  MappedResponse processResponse(http.Response? response) {
    throw UnimplementedError();
  }
}
