import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'dart:developer';

import 'api_response_handler.dart';

class HttpWrapper {
  static late var _http;
  static bool isSSLEnabled = false;
  static Map<String, HttpWrapper> _instanceCache = {};
  late ApiResponseHandler _apiResponseHandler;
  static Dio dio = Dio();

  HttpWrapper._internal(ApiResponseHandler apiResponseHandler) {
    _apiResponseHandler = apiResponseHandler;
  }

  static Future<HttpWrapper?> create(
      String name, ApiResponseHandler apiResponseHandler) async {
    if (!_instanceCache.containsKey(name)) {
      await _init();

      _instanceCache[name] = HttpWrapper._internal(apiResponseHandler);
    }

    return _instanceCache[name];
  }

  static _init() async {
    if (isSSLEnabled) {
      // Apply SSL certificate on http layer which automatically checks certificate before the network handshake
      var context = await _setTrustedCertificateContext();
      final ioc = HttpClient(context: context);
      _http = IOClient(ioc);
    } else {
      // Temporary For development purpose allow bad certificates
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      _http = IOClient(ioc);
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  static Future<SecurityContext> _setTrustedCertificateContext() async {
    // ByteData data = await rootBundle.load('assets/liveCertificate.crt');
    ByteData data = await rootBundle.load('assets/certificate.pem');
    SecurityContext context = SecurityContext();
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());
    return context;
  }

  Future<dynamic> get(String url,
      {String? id,
      String? token,
      String? userID,
      Map<String, dynamic>? queryParameters}) async {
    await checkInternetAvailable();

    String uriWithId = '$url${id == null ? '' : '/$id'}';
    String query = _buildQuery(queryParameters);
    Uri uri = Uri.parse('$uriWithId${query.isNotEmpty ? '?$query' : ''}');
    var headers = await _apiResponseHandler.httpheaders(
        token, 'application/json', userID);
    if (!kReleaseMode) {
      log(uri.toString());

      // print(uri.toString());
      log(headers.toString());
    }

    var res = await _http
        .get(uri, headers: headers)
        .timeout(const Duration(seconds: 80));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> post(String url,
      {required dynamic body,
      String? token,
      String? userID,
      Map<String, String>? queryParameters}) async {
    await checkInternetAvailable();
    // var uri = Uri.parse('$url');
    String query = _buildQuery(queryParameters);
    Uri uri = Uri.parse('$url${query.isNotEmpty ? '?$query' : ''}');
    var headers = await _apiResponseHandler.httpheaders(
        token, 'application/json', userID);
    // log(uri.toString());

    if (!kReleaseMode) {
      log(uri.toString());
      // print(uri.toString());
      log(headers.toString());
      // print(body != null ? json.encode(body) : body);
      log(body != null ? json.encode(body) : body);
    }
    var res = await _http
        .post(uri,
            body: body == null ? body : json.encode(body), headers: headers)
        .timeout(const Duration(seconds: 30));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> fileUpload(
      {required url, String? token, String? userID, FormData? formdata}) async {
    await checkInternetAvailable();
    log(url.toString());
    log(token.toString());
    var headers = await _apiResponseHandler.httpheaders(
        token, 'application/json', userID);
    // if (isSSLEnabled) {
    //   var context = await _setTrustedCertificateContext();
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     HttpClient httpClient = new HttpClient(context: context);
    //     return httpClient;
    //   };
    // }

// Dio dio = new Dio();
// FormData formdata = new FormData(); // just like JS
// formdata.add("photos", new UploadFileInfo(_image, basename(_image.path)));
// dio.post(uploadURL, data: formdata, options: Options(
// method: 'POST',
// responseType: ResponseType.PLAIN // or ResponseType.JSON
// ))
// .then((response) => print(response))
// .catchError((error) => print(error));

//JD moved to screen
    // if (file == null) return;
    // // String base64Image = base64Encode(file.readAsBytesSync());
    // String fileName = file.path.split("/").last;
    // FormData formdata = new FormData.fromMap({
    //   // "X-Api-token": GlobalConstants.apiToken,
    //   // "Cookies": 'token=$token',
    //   // "file": File(file.path),
    //   "imageURL": await MultipartFile.fromFile(file.path, filename: fileName),
    //   // "files": [
    //   //   await MultipartFile.fromFile("./text1.txt", filename: "text1.txt"),
    //   //   await MultipartFile.fromFile("./text2.txt", filename: "text2.txt"),
    //   // ]
    // });
    var response = await dio.post(url,
        data: formdata,
        options: Options(
            method: 'POST', responseType: ResponseType.json, headers: headers));

    DioApiResponseHandler dioApiResponseHandler = DioApiResponseHandler();
    MappedResponse processed =
        dioApiResponseHandler.processDioResponse(response);
    return _returnResponse(processed);
  }

  Future<dynamic> put(
    String url, {
    required Map<String, dynamic> body,
    String? token,
    String? userID,
  }) async {
    await checkInternetAvailable();

    var uri = Uri.parse(url);
    var headers = await _apiResponseHandler.httpheaders(
        token, 'application/json', userID);

    if (!kReleaseMode) {
      log(uri.toString());
      log(headers.toString());
      // print(body != null ? json.encode(body) : body);
      log(body != (null) ? json.encode(body) : body as String);
    }

    var res = await _http
        .put(uri,
            body: body == (null) ? body : json.encode(body), headers: headers)
        .timeout(const Duration(seconds: 30));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> patch(
    String url, {
    required Map<String, dynamic> body,
    String? token,
    String? userID,
    Map<String, String>? queryParameters,
  }) async {
    await checkInternetAvailable();

    String query = _buildQuery(queryParameters);
    var uri = Uri.parse("$url${query.isNotEmpty ? '?$query' : ''}");
    var headers = await _apiResponseHandler.httpheaders(
        token, 'application/json', userID);

    if (!kReleaseMode) {
      log(uri.toString());
      log(headers.toString());
      // print(body != null ? json.encode(body) : body);
      log(body != (null) ? json.encode(body) : body as String);
    }

    var res = await _http
        .patch(uri,
            body: body == (null) ? body : json.encode(body), headers: headers)
        .timeout(const Duration(seconds: 30));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? body,
    String? token,
    String? userID,
    Map<String, String>? queryParameters,
  }) async {
    await checkInternetAvailable();

    String query = _buildQuery(queryParameters);
    var uri = Uri.parse("$url${query.isNotEmpty ? '?$query' : ''}");
    var headers = await _apiResponseHandler.httpheaders(
      token,
      'application/json',
      userID,
    );

    if (!kReleaseMode) {
      log(uri.toString());
      log(headers.toString());
      // print(body != null ? json.encode(body) : body);
      log(body != null ? json.encode(body) : body as String);
    }

    var res = await _http
        .delete(uri, headers: headers, body: json.encode(body))
        .timeout(const Duration(seconds: 30));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> postFormData(
    String url, {
    required Map<String, dynamic>? body,
    String? token,
    String? userID,
  }) async {
    await checkInternetAvailable();

    var uri = Uri.parse(url);

    // var headers = {'application': 'x-www-form-urlencoded'};
    // if (token != null)
    //   headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    var headers = await _apiResponseHandler.httpheaders(
      token,
      'application/x-www-form-urlencoded',
      userID,
    );
    // var headers =  await _apiResponseHandler.httpheaders(token, 'application/json');

    if (!kReleaseMode) {
      log(uri.toString());
      log(headers.toString());
      log(body != null ? json.encode(body) : body as String);
    }
    var res = await _http
        .post(uri,
            body: body, encoding: Encoding.getByName('utf-8'), headers: headers)
        .timeout(const Duration(seconds: 30));

    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> patchFormData(
    String url, {
    required Map<String, dynamic> body,
    String? token,
    String? userID,
    Map<String, String>? queryParameters,
    List<File>? files,
  }) async {
    await checkInternetAvailable();

    String query = _buildQuery(queryParameters);
    var uri = "$url${query.isNotEmpty ? '?$query' : ''}";

    dio.options.headers = await _apiResponseHandler.httpheaders(
        token, 'multipart/form-data', userID);
    if (isSSLEnabled) {
      var context = await _setTrustedCertificateContext();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        HttpClient httpClient = HttpClient(context: context);
        return httpClient;
      };
    }

    var formData = FormData.fromMap(body);

    var response = await dio.patch(uri, data: formData);
    MappedResponse processed = _apiResponseHandler.processDioResponse(response);
    return _returnResponse(processed);
  }

  Future<dynamic> multipart(String url,
      {required Map<String, dynamic> body,
      String? token,
      String? userID,
      List<File>? files}) async {
    await checkInternetAvailable();

    dio.options.headers = await _apiResponseHandler.httpheaders(
        token, 'multipart/form-data', userID);
    if (isSSLEnabled) {
      var context = await _setTrustedCertificateContext();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        HttpClient httpClient = HttpClient(context: context);
        return httpClient;
      };
    }

    var formData = FormData.fromMap(body);

    if (files != null && files.isNotEmpty) {
      for (var i = 0; i < files.length; i++) {
        var file = await MultipartFile.fromFile(files[i].path);
        formData.files.add(MapEntry('files', file));
      }
    }

    var response = await dio.post(url, data: formData);
    MappedResponse processed = _apiResponseHandler.processDioResponse(response);
    return _returnResponse(processed);
  }

  Future<dynamic> getHTML(
    String url, {
    String? token,
    String? userID,
  }) async {
    await checkInternetAvailable();

    dio.options.headers =
        await _apiResponseHandler.httpheaders(token, 'text/html', userID);
    if (isSSLEnabled) {
      var context = await _setTrustedCertificateContext();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        HttpClient httpClient = HttpClient(context: context);
        return httpClient;
      };
    }

    var response = await dio.get(url);
    return response;
  }

  String _buildQuery(Map<String, dynamic>? queryParameters) {
    String query = '';
    queryParameters?.forEach((key, value) => query += '$key=$value&');

    return query.isNotEmpty ? query.substring(0, query.length - 1) : query;
  }

  _returnResponse(MappedResponse processed) {
    if (processed.success!) {
      return processed.content;
    } else {
      throw HttpCustomException(
          code: processed.code,
          message: processed.message,
          apiCode: processed.errorCode);
    }
  }

  // Map<String, String> _setDefaultHeaders(String token, dynamic body) {
  //   var headers = new Map<String, String>();

  //   headers[HttpHeaders.contentTypeHeader] = 'application/json';

  //   if (token != null)
  //     headers[HttpHeaders.authorizationHeader] = "Bearer $token";

  //   headers['locale'] = LocalizationService.locale.languageCode;

  //   return headers;
  // }

  Future<void> checkInternetAvailable() async {
    return;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile ||
    //     connectivityResult == ConnectivityResult.wifi) {
    //   return;
    // } else {
    //   throw new HttpCustomException(
    //       code: 8000, message: "Please Check your internet connection.");
    // }
  }
}

class HttpCustomException implements IOException {
  int? code;
  String? message;
  String? apiCode;

  HttpCustomException({this.code, this.message, this.apiCode = ''});

  @override
  String toString() {
    var b = StringBuffer()..write(message);
    return b.toString();
  }
}

class BadRequestException extends HttpException {
  BadRequestException({String message = 'The request is invalid.'})
      : super(message);

  @override
  String toString() {
    var b = StringBuffer()
      ..write('BadRequestException: ')
      ..write(message);
    return b.toString();
  }
}

class UnauthorizedAccessException extends HttpException {
  UnauthorizedAccessException(
      {String message = 'User not allowed to perform this operation'})
      : super(message);

  @override
  String toString() {
    var b = StringBuffer()
      ..write('UnauthorizedAccessException: ')
      ..write(message);
    return b.toString();
  }
}

class ResourceNotFoundException extends HttpException {
  ResourceNotFoundException({String message = ''}) : super(message);

  @override
  String toString() {
    var b = StringBuffer()
      ..write('ResourceNotFoundException: ')
      ..write(message);
    return b.toString();
  }
}
