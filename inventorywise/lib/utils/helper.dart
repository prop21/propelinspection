import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:InventoryWise/utils/global.dart';

class Helper {


  static Future<AppVersion> computeAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String? version;
    // if (Platform.isIOS) {
    //   version = packageInfo.buildNumber;
    // } else if (Platform.isAndroid) {
    //   version = packageInfo.version;
    // }
    return AppVersion(packageInfo.buildNumber, packageInfo.version);
  }
}

class AppVersion {
  final String? buildNumber;
  final String? version;

  AppVersion(this.buildNumber, this.version);
}
