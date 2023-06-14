import 'package:InventoryWise/service/auth_service/auth_service.dart';
import 'package:InventoryWise/service/home/home_service.dart';
import 'package:InventoryWise/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../http/exception_checker.dart';
import '../../models/homedata/Home_Data.dart';
import '../home_screen/home_screen.dart';

class ForgetController extends GetxController {
  final auth = Authenticator();
  var isLoading = true.obs;
  var hide=true.obs;
  var data=<Rows>[].obs;

  final authService = AuthenticationService();
  var et1 = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    resetpassword("");
  }

  Future<void> resetpassword(email) async {
    try {
      isLoading(true);
      var result = await authService.forget(email);

      isLoading(false);

    } on Exception catch (e) {
      print("hello");
      Get.defaultDialog();
      isLoading(false);
      ExceptionHandler().handleException(e);
    }
  }
}
