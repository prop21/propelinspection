import 'dart:io';

import 'package:InventoryWise/views/forgot_password/forgot_password_screen.dart';
import 'package:InventoryWise/views/register/register_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/global.dart';
import '../login/login_screen.dart';

class Register_Screen extends StatelessWidget {
  final controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
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
                  "Personal Info",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "First Name",
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
                  "Last Name",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.et2,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.et3,
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
                  controller: controller.et4,
                  obscureText: controller.hide.value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: InkWell(
                          onTap: () {
                            if (controller.hide.value == false) {
                              controller.hide.value = true;
                            } else {
                              controller.hide.value = false;
                            }
                          },
                          child: Icon(controller.hide.value
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Company Info",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {

                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      try {
                        final ImagePicker picker = ImagePicker();
// Pick an image.
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);
                        File imagedata = File(pickedFile!.path);
                        if (imagedata == null) return;
                        final imageTemp = File(imagedata.path);
                        imageTemp;
                        controller.cplogo.value =
                            await controller.upload(imageTemp);
                        prefs.setString("logo", controller.cplogo.value);
                      } on PlatformException catch (e) {
                        print('Failed to pick image: $e');
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage: controller.cplogo.value != ""
                          ? NetworkImage(
                              Paths.baseUrl +
                                  "/" +
                                  controller.cplogo.value.toString(),
                            )
                          : NetworkImage(
                              "https://www.shareicon.net/data/2015/09/01/94161_add_512x512.png"),
                      radius: 60,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Company Name",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.et5,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Company Phone",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.et6,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Company Email",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.et7,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Company Address",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.et8,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: MaterialButton(
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onPressed: () {
                      controller.register(
                          "MR",
                          controller.et1.text,
                          controller.et2.text,
                          controller.et3.text,
                          controller.et4.text,
                          controller.et4.text,
                          true,
                          controller.et8.text,
                          controller.cplogo.value);
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
                        Get.offAll(() => Login_Screen());
                      },
                      child: Text(
                        "Already have account?Login",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
