import 'package:InventoryWise/views/forgot_password/forget_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Forgot_Screen extends StatelessWidget {
  final controller=Get.put(ForgetController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/splash/splash.png",
              height: 250,
              width: Get.width,
              fit: BoxFit.fitWidth,
            ),
            Text("Enter your valid email",style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 16),),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.et1,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: MaterialButton(
                child: Text(
                  "Get Password Reset Link",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                onPressed: () {
                  controller.resetpassword(controller.et1.text);
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
      ),
    );
  }
}
