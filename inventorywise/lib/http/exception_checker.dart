import 'dart:async';
import 'package:get/get.dart';


import 'package:InventoryWise/utils/global.dart';

import 'dart:io';
import 'package:InventoryWise/widgets/custom_dialogs.dart';


import 'http.dart';

class ExceptionData {
  String? title;
  String? message;
  int? code;
  ExceptionData({this.title, this.message, this.code = -1});
}

class ExceptionHandler {
  static final ExceptionHandler _exceptionHandler =
      ExceptionHandler._internal();
  ExceptionHandler._internal();
  factory ExceptionHandler() => _exceptionHandler;

  Future<void> handleException(Exception e, {bool showDialog = true}) async {
    var data = _makeException(e);

    if (showDialog && data != null) {
      await Get.dialog(
          GenericAppDialog(
            message: data.message,
          ),
          barrierDismissible: false);

      // if (data.code == 401) {
      //   Get.offAll(() => const LandingPage());
      //   // Get.offAll(() => const PhoneNumberPage());
      // }
    }
    // return data;
  }

  _makeException(Exception e) {
    switch (e.runtimeType) {
      case TimeoutException:
        return ExceptionData(
            title: "TimeoutException",
            message: "Check your internet connection.");
      case SocketException:
        return ExceptionData(
            title: "Connectivity", message: "Check your internet connection.");

      case HttpException:
        return ExceptionData(
            title: "Error", message: (e as HttpException).message);

      case HttpCustomException:
        return ExceptionData(
            title: "Error",
            message: (e as HttpCustomException).message,
            code: e.code);
      case BadRequestException:
        return ExceptionData(
            title: "BadRequestException", message: "Bad Request");
      case UnauthorizedAccessException:
        // _handleUnauthorizeException();
        break;
      case ResourceNotFoundException:
        return ExceptionData(
            title: "ResourceNotFoundException", message: "Bad Request");
      case FeeException:
        return ExceptionData(
            title: "FeeException", message: (e as FeeException).message);
      default:
        return ExceptionData(
            title: "Error", message: "Unable to process request.");
    }
  }

  // Future<void> _handleUnauthorizeException() async {
  //   final UserRepo _userRepo = UserRepo();
  //   await Get.dialog(ConfirmationDialog(
  //     heading: "Session Expired",
  //     body: "Your session has expired.",
  //     cancelButtonText: "cancel".tr,
  //     isCancelPressed: () {
  //       _userRepo.loggedOut(globalCache.customerInfo!.phoneNumber!);
  //       authenticator.resetUser();
  //       SegmentHandler().reset();
  //       Get.offAll(() => const LandingPage());
  //     },
  //     confirmButtonText: "login".tr,
  //     isConfirmPressed: () async {
  //       String mobile = UserRepo().getSelectedMobile();
  //       Get.close(2);
  //       VerifyOtpResponse? smsOtpResponse = await Get.to(() => OtpWidget(
  //             otpType: UserType.phone,
  //             titleValue: mobile,
  //             moduleId: ModuleIDs.login,
  //             timerLimitInSec: 20,
  //           ));
  //       if (smsOtpResponse != null && smsOtpResponse.token != null) {
  //         Get.find<HomeController>().getCustomerInfo();
  //         UserDetails? details = UserRepo().readById(mobile);
  //         if (details != null) {
  //           details.userToken = smsOtpResponse.token!;
  //           await UserRepo().save(mobile, details);
  //         }
  //       }
  //     },
  //   ));
  // }
}

class FeeException extends HttpException {
  FeeException({String message = ''}) : super(message);

  @override
  String toString() {
    var b = StringBuffer()
      ..write('FeeException: ')
      ..write(message);
    return b.toString();
  }
}
