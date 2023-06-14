import 'package:InventoryWise/views/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Landing_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset("assets/splash/splash.png"),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: MaterialButton(
              child: Text(
                "GET STARTED",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              onPressed: () {
                Get.off(()=>Login_Screen());
              },
              color: Colors.blue,
              height: 50,
              minWidth: Get.width - 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
