import 'package:InventoryWise/service/auth_service/auth_service.dart';
import 'package:InventoryWise/service/home/home_service.dart';
import 'package:InventoryWise/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../http/exception_checker.dart';
import '../../models/homedata/Home_Data.dart';
import '../home_screen/home_screen.dart';

class HomeController extends GetxController {
  final auth = Authenticator();
  var isLoading = true.obs;
  var hide = true.obs;
  var data = <Rows>[].obs;
  final authService = HomeService();
  var et1 = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getData("1");
  }

  Future<void> getData(id) async {
    try {
      isLoading(true);
      var result = await authService.getData(id);
      data.value = result.rows!;
      isLoading(false);
    } on Exception catch (e) {
      print("hello");
      Get.defaultDialog();
      isLoading(false);
      ExceptionHandler().handleException(e);
    }
  }
}
