import 'package:InventoryWise/service/auth_service/auth_service.dart';
import 'package:InventoryWise/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void onInit() async {
    super.onInit();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("id").toString() != "null") {
      Authenticator().setUserID(prefs.get("id").toString());
      Get.offAll(() => Home_Screen(
            id: prefs.get("id").toString(),
          ));
    }
  }

  Future<void> login(email, pass) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      var result = await authService.login(email, pass);
      isLoading(false);
      if (result.isVerified==true) {
        Authenticator().setUserID(result.id.toString());
        Authenticator().setEmail(result.email.toString());
        Authenticator().setLogo(result.companyLogo.toString());
        prefs.setString("id", result.id.toString());
        prefs.setString("email", result.email.toString());
        prefs.setString("logo", result.companyLogo.toString());
        Get.offAll(() => Home_Screen(
              id: result.id.toString(),email: result.email,lname: result.lastName,fname:result.firstName ,
            ));
      }
    } on Exception catch (e) {
      Get.defaultDialog();
      isLoading(false);
      ExceptionHandler().handleException(e);
    }
  }
}
