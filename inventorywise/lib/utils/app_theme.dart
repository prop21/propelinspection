import 'package:flutter/material.dart';

class AppTheme {
  static MaterialColor appDefaultMaterialColor =
      const MaterialColor(0xFFE72E80, {
    50: Color.fromRGBO(231, 46, 128, .1),
    100: Color.fromRGBO(231, 46, 128, .2),
    200: Color.fromRGBO(231, 46, 128, .3),
    300: Color.fromRGBO(231, 46, 128, .4),
    400: Color.fromRGBO(231, 46, 128, .5),
    500: Color.fromRGBO(231, 46, 128, .6),
    600: Color.fromRGBO(231, 46, 128, .7),
    700: Color.fromRGBO(231, 46, 128, .8),
    800: Color.fromRGBO(231, 46, 128, .9),
    900: Color.fromRGBO(231, 46, 128, 1),
  });
  static Color primaryColor = const Color(0xFFE72E80);
  static Color primaryColorAccent = const Color(0xFFFF66AA);
  static Color secondaryColor = const Color(0xFFF14668);
  static Color greyColor = const Color(0xff66819F);
  static Color lightPinkGreyColor = const Color(0xffFCEBF3);
  static Color headerYellowColor = const Color(0xffFF970B);
  static Color headerYellowColorLight = const Color(0xffFFC16C);
  static Color caveGreyColor = HexColor("#a7b2c6");
  static Color secondaryTextColor = const Color.fromRGBO(0, 0, 0, 0.5);

  static ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
    radius: const Radius.circular(10),
    isAlwaysShown: true,
    mainAxisMargin: 16,
    thumbColor: MaterialStateProperty.all<Color>(
        AppTheme.primaryColor.withOpacity(0.5)),
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  // @override
  // String toString() {
  //   return super.toString();
  // }
}
