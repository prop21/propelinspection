import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstants {
  var countryCode = "92";
  var inviteDeeplink = "https://firebase.qisstpay.com/1S8k";
  static int searchLength = 2;
  String basicToken = "Basic 9dd5f03c76bc3f191b53f4e97b444df0c0998ce8";
  static double toolBarHeight = Get.size.height * 0.3;

  static TextStyle get boldTextStyle => const TextStyle(
        color: Color(0xff3F3F40),
        fontSize: 35,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get normalTextStyle => const TextStyle(
        color: Color(0xff3F3F40),
        fontSize: 35,
      );
  maskCharacters(String value, int maskingLength) {
    if (value.isEmpty) {
      return value;
    }
    String result = value.replaceRange(0, maskingLength, '*' * maskingLength);
    // ignore: avoid_print
    print("original: $value  replaced: $result");
    return result;
  }

  static Duration get pageViewDuration => const Duration(milliseconds: 1000);
  static Curve get pageViewCurve => Curves.easeInOutCubic;
}
