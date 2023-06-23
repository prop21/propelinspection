import 'package:InventoryWise/service/auth_service/auth_service.dart';
import 'package:InventoryWise/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../http/exception_checker.dart';
import '../../service/home/home_service.dart';
import '../home_screen/home_screen.dart';

class RegisterController extends GetxController {
  final auth = Authenticator();
  var service = HomeService();
  var isLoading = true.obs;
  var hide=true.obs;
  var cplogo="".obs;
  final authService = AuthenticationService();
  var et1 = TextEditingController();
  var et2 = TextEditingController();
  var et3 = TextEditingController();
  var et4 = TextEditingController();
  var et5 = TextEditingController();
  var et6 = TextEditingController();
  var et7 = TextEditingController();
  var et8 = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }
  Future<String> upload(images) async {
    return await service.uploadImage(images.path);
  }
  Future<void> register(title,firstname,lastname,email,confirmpassword,password,acceptterm,companyaddress,logo) async {
    try {
      isLoading(true);
      var result = await authService.register(title,firstname,lastname,email,confirmpassword,password,acceptterm,companyaddress,logo);
      isLoading(false);
    } on Exception catch (e) {
      Get.defaultDialog();
      isLoading(false);
      ExceptionHandler().handleException(e);
    }
  }
}
