import 'package:InventoryWise/service/auth_service/auth_service.dart';
import 'package:InventoryWise/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../http/exception_checker.dart';
import '../home_screen/home_screen.dart';

class LoginController extends GetxController {
  final auth = Authenticator();
  var isLoading = true.obs;
  var hide = true.obs;
  final authService = AuthenticationService();
  var et1 = TextEditingController();
  var et2 = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login(email, pass) async {
    try {
      isLoading(true);
      var result = await authService.login(email, pass);
      isLoading(false);
      if (result.isVerified == null) {
        Authenticator().setUserID(result.id.toString());
        Get.offAll(() => Home_Screen(
              id: result.id,
            ));
      }
    } on Exception catch (e) {
      print("hello");
      Get.defaultDialog();
      isLoading(false);
      ExceptionHandler().handleException(e);
    }
  }
}
