import 'package:InventoryWise/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'InventoryWise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash_Screen(),
    );
  }
}




