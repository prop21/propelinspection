import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../landing/landing_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
        Duration(seconds: 3),
        () =>
            Get.off(() => Landing_Screen(), transition: Transition.leftToRight));
  }
}

class Splash_Screen extends StatelessWidget {
  final SplashScreenController carouselController =
      Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Image.asset("assets/splash/splash.png"),
      ),
    );
  }
}
