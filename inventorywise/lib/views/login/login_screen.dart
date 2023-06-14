import 'package:InventoryWise/views/forgot_password/forgot_password_screen.dart';
import 'package:InventoryWise/views/home_screen/home_screen.dart';
import 'package:InventoryWise/views/login/login_controller.dart';
import 'package:InventoryWise/views/register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/addproperty/add_proprert_model.dart';

class Login_Screen extends StatelessWidget {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Obx(
        () => Padding(
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
              Text(
                "Username",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8), fontSize: 16),
              ),
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
              Text(
                "Password",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8), fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                obscureText: controller.hide.value,
                controller: controller.et2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: InkWell(
                        onTap: () {
                          if (controller.hide.value) {
                            controller.hide.value = false;
                          } else {
                            controller.hide.value = true;
                          }
                        },
                        child: Icon(controller.hide.value
                            ? Icons.visibility
                            : Icons.visibility_off))),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: MaterialButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    if (controller.et1.text.isNotEmpty &&
                        controller.et2.text.isNotEmpty) {
                      print(controller.et1.text.toString());
                      controller.login(controller.et1.text.toString(),
                          controller.et2.text.toString());
                    } else {
                      Get.defaultDialog(
                          title: "Input Field Is Missing",
                          middleText: "Enter Correct email and password");
                    }


                  },
                  color: Colors.blue,
                  height: 50,
                  minWidth: Get.width - 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => Forgot_Screen());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => Register_Screen());
                    },
                    child: Text(
                      "Don\'t have an account? Register Here",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
