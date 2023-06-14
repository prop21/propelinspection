import 'dart:convert';
import 'dart:typed_data';

import 'package:InventoryWise/models/addproperty/add_proprert_model.dart';
import 'package:InventoryWise/views/home_screen/add_data/add_data_controller.dart';

import 'package:easy_signature_pad/easy_signature_pad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';

import '../../../widgets/custom_property.dart';

class UpdateDataScreen extends StatefulWidget {
  UpdateDataScreenState createState() => UpdateDataScreenState();
  UpdateDataScreen({this.id});
  var id;
}

class UpdateDataScreenState extends State<UpdateDataScreen> {
  final controller = Get.put(AddDataController());
  AddPropertyModel? model;
  List<PropertyDetails> pd = [];
  List<List<String>> images = [];
  @override
  Widget build(BuildContext context) {
    model = AddPropertyModel();
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false, // fluter 2.x
      appBar: AppBar(
        title: Text("Update Property"),
        centerTitle: true,
      ),

      body: Obx(
            () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Property Report Type",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40.0,
                  width: Get.width,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) => Container(
                        margin: EdgeInsets.only(right: 10),
                        child: MaterialButton(
                          height: 35,
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Colors.blue,
                          onPressed: () {
                            if (controller.index.value == 0) {
                              controller.type.value = "Inventory Report";
                            }
                            if (controller.index.value == 1) {
                              controller.type.value = "Mid Term Inspection";
                            }
                            if (controller.index.value == 2) {
                              controller.type.value = "Checkout Report";
                            }
                          },
                          child: Text(controller.index == 0
                              ? "Inventory Report"
                              : index == 1
                              ? "Mid Term Inspection"
                              : "Checkout Report"),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Property Main Picture",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  height: 120,
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: controller.image[0]!.path.isNotEmpty
                      ? Stack(children: [
                    Image.file(
                      File(controller.image[0]!.path.toString()),
                      fit: BoxFit.fill,
                      height: 120,
                      width: Get.width,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: EdgeInsets.only(right: 5, top: 5),
                            child: InkWell(
                                onTap: () {
                                  controller.image[0] = File("");
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )))),
                  ])
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          controller.image[0] =
                          await controller.pickImages();
                          if (controller.image[0] != null) {
                            controller.mainimage = await controller
                                .upload(controller.image[0]);
                          }
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          var img = await controller.pickImageGallerys();
                          if (img != null) {
                            controller.mainimage =
                            await controller.upload(img);
                          }
                        },
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  "Property Address",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.f[0],
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tenant Name",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.f[1],
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Inspector Name",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.f[2],
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Inspection Date",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    controller.f[3].text = pickedDate!.year.toString() +
                        "-" +
                        pickedDate.month.toString() +
                        "-" +
                        pickedDate.day.toString();
                  },
                  child: TextField(
                    enabled: false,
                    controller: controller.f[3],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_month)),
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "ECP Expiry Date",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    controller.f[4].text = pickedDate!.year.toString() +
                        "-" +
                        pickedDate.month.toString() +
                        "-" +
                        pickedDate.day.toString();
                  },
                  child: TextField(
                    enabled: false,
                    controller: controller.f[4],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_month)),
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "ECIR Expiry Date",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    controller.f[5].text = pickedDate!.year.toString() +
                        "-" +
                        pickedDate.month.toString() +
                        "-" +
                        pickedDate.day.toString();
                  },
                  child: TextField(
                    enabled: false,
                    controller: controller.f[5],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_month)),
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Gas Saftey Certificate Expiry Date",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    controller.f[6].text = pickedDate!.year.toString() +
                        "-" +
                        pickedDate.month.toString() +
                        "-" +
                        pickedDate.day.toString();
                  },
                  child: TextField(
                    enabled: false,
                    controller: controller.f[6],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_month)),
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 50,
                      child: Text(
                        "Pre-Paid Electricity Meter",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: (Get.width / 2) - 50,
                      child: Text(
                        "Reading",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            controller.t1.value = "Working";
                          },
                          minWidth: 80,
                          color: controller.t1.value == "Working"
                              ? Colors.blue
                              : Colors.white,
                          child: Text("Yes"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MaterialButton(
                          minWidth: 80,
                          color: controller.t1.value == "Not Working"
                              ? Colors.blue
                              : Colors.white,
                          onPressed: () {
                            controller.t1.value = "Not Working";
                          },
                          child: Text("No"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 70,
                          height: 35,
                          child: TextField(
                            controller: controller.f[7],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                bottom: 12, // HERE THE IMPORTANT PART
                              ),
                              filled: true,
                              fillColor: Colors.blue, //<-- SEE HERE
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.image[1]!.path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[1]!.path.toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[1] = File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.image[1] = await controller.pickImages();
                                  if (controller.image[1] != null) {
                                    controller.electricmeterfront =
                                    await controller.upload(controller.image[1]);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.image[1] = await controller
                                      .pickImageGallerys();
                                  if (controller.image[1] != null) {
                                    controller.electricmeterfront =
                                    await controller.upload(controller.image[1]);
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 50,
                      child: Text(
                        "Pre-Paid Gas Meter",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: (Get.width / 2) - 50,
                      child: Text(
                        "Reading",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            controller.t2.value = "Working";
                          },
                          minWidth: 80,
                          color: controller.t2.value == "Working"
                              ? Colors.blue
                              : Colors.white,
                          child: Text("Yes"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MaterialButton(
                          minWidth: 80,
                          color: controller.t2.value == "Not Working"
                              ? Colors.blue
                              : Colors.white,
                          onPressed: () {
                            controller.t2.value = "Not Working";
                          },
                          child: Text("No"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 70,
                          height: 35,
                          child: TextField(
                            controller: controller.f[8],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue, //<-- SEE HERE
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.image[2].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[2].path.toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[2] = File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : controller.image[2].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[2].path
                                  .toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[2] =
                                              File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.image[2] =
                                  await controller.pickImages();
                                  if (controller.image[2] != null) {
                                    controller.gasmeterfront =
                                    await controller.upload(controller.image[2]);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.image[2] = await controller
                                      .pickImageGallerys();
                                  if (controller.image[0] != null) {
                                    controller.gasmeterfront =
                                    await controller.upload(controller.image[2]);
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 50,
                      child: Text(
                        "Water Meter",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: (Get.width / 2) - 50,
                      child: Text(
                        "Reading",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            controller.t3.value = "Working";
                          },
                          minWidth: 80,
                          color: controller.t3.value == "Working"
                              ? Colors.blue
                              : Colors.white,
                          child: Text("Yes"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MaterialButton(
                          minWidth: 80,
                          color: controller.t3.value == "Not Working"
                              ? Colors.blue
                              : Colors.white,
                          onPressed: () {
                            controller.t3.value = "Not Working";
                          },
                          child: Text("No"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 70,
                          height: 35,
                          child: TextField(
                            controller: controller.f[9],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue, //<-- SEE HERE
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.image[3].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[3].path.toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[3] = File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : controller.image[3].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[3].path
                                  .toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[3] =
                                              File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.image[3] =
                                  await controller.pickImages();
                                  if (controller.image[3] != null) {
                                    controller.watermeterfront =
                                    await controller.upload(controller.image[3]);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.image[3] = await controller
                                      .pickImageGallerys();
                                  if (controller.image[3] != null) {
                                    controller.watermeterfront =
                                    await controller.upload(controller.image[3]);
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 50,
                      child: Text(
                        "Smoke Alarm",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: (Get.width / 2) - 50,
                      child: Text(
                        "",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            controller.t4.value = "Working";
                          },
                          minWidth: 80,
                          color: controller.t4.value == "Working"
                              ? Colors.blue
                              : Colors.white,
                          child: Text("Yes"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MaterialButton(
                          minWidth: 80,
                          color: controller.t4.value == "Not Working"
                              ? Colors.blue
                              : Colors.white,
                          onPressed: () {
                            controller.t4.value = "Not Working";
                          },
                          child: Text("No"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.image[4].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[4].path.toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[4] = File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : controller.image[4].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[4].path
                                  .toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[4] =
                                              File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.image[4] =
                                  await controller.pickImages();
                                  if (controller.image[4] != null) {
                                    controller.smokealarmfront =
                                    await controller.upload(controller.image[4]);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.image[4] = await controller
                                      .pickImageGallerys();
                                  if (controller.image[4] != null) {
                                    controller.smokealarmfront =
                                    await controller.upload(controller.image[4]);
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.image[5].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[5].path.toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[5] = File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : controller.image[5].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[5].path
                                  .toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[5] =
                                              File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.image[5] =
                                  await controller.pickImages();
                                  if (controller.image[5] != null) {
                                    controller.smokealarmback =
                                    await controller.upload(controller.image[5]);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.image[5] = await controller
                                      .pickImageGallerys();
                                  if (controller.image[5] != null) {
                                    controller.smokealarmback =
                                    await controller.upload(controller.image[5]);
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 50,
                      child: Text(
                        "CO Alarm",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: (Get.width / 2) - 50,
                      child: Text(
                        "",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            controller.t5.value = "Working";
                          },
                          minWidth: 80,
                          color: controller.t5.value == "Working"
                              ? Colors.blue
                              : Colors.white,
                          child: Text("Yes"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MaterialButton(
                          minWidth: 80,
                          color: controller.t5.value == "Not Working"
                              ? Colors.blue
                              : Colors.white,
                          onPressed: () {
                            controller.t5.value = "Not Working";
                          },
                          child: Text("No"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.image[6].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[6].path.toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[6] = File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : controller.image[6].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[6].path
                                  .toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[6] =
                                              File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.image[6] =
                                  await controller.pickImages();
                                  if (controller.image[6] != null) {
                                    controller.coalarmfront =
                                    await controller.upload(controller.image[6]);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.image[6] = await controller
                                      .pickImageGallerys();
                                  if (controller.image[6] != null) {
                                    controller.coalarmfront =
                                    await controller.upload(controller.image[6]);
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.image[7].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[7].path.toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[7] = File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : controller.image[7].path.isNotEmpty
                              ? Stack(children: [
                            Image.file(
                              File(controller.image[7].path
                                  .toString()),
                              fit: BoxFit.fill,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.image[7] =
                                              File("");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))),
                          ])
                              : Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.image[7] =
                                  await controller.pickImages();
                                  if (controller.image[7] != null) {
                                    controller.coalarmback =
                                    await controller.upload(controller.image[7]);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.image[7] = await controller
                                      .pickImageGallerys();
                                  if (controller.image[7] != null) {
                                    controller.coalarmback =
                                    await controller.upload(controller.image[7]);
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 50,
                      child: Text(
                        "Heating System",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: (Get.width / 2) - 50,
                      child: Text(
                        "",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          controller.t6.value = "Working";
                        },
                        minWidth: 80,
                        color: controller.t6.value == "Working"
                            ? Colors.blue
                            : Colors.white,
                        child: Text("Yes"),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      MaterialButton(
                        minWidth: 80,
                        color: controller.t6.value == "Not Working"
                            ? Colors.blue
                            : Colors.white,
                        onPressed: () {
                          controller.t6.value = "Not Working";
                        },
                        child: Text("No"),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 70, height: 35,

                        //   child:TextField(
                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Colors.blue,//<-- SEE HERE
                        //   ),
                        // ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 38,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: controller.image[8].path.isNotEmpty
                            ? Stack(children: [
                          Image.file(
                            File(controller.image[8].path.toString()),
                            fit: BoxFit.fill,
                            height: 120,
                            width: Get.width,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding:
                                  EdgeInsets.only(right: 5, top: 5),
                                  child: InkWell(
                                      onTap: () {
                                        controller.image[8] = File("");
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )))),
                        ])
                            : controller.image[8].path.isNotEmpty
                            ? Stack(children: [
                          Image.file(
                            File(
                                controller.image[8].path.toString()),
                            fit: BoxFit.fill,
                            height: 120,
                            width: Get.width,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 5, top: 5),
                                  child: InkWell(
                                      onTap: () {
                                        controller.image[8] =
                                            File("");
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )))),
                        ])
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                controller.image[8] =
                                await controller.pickImages();
                                if (controller.image[8] != null) {
                                  controller.heatingsystem =
                                  await controller.upload(controller.image[8]);
                                }
                              },
                              child: Icon(
                                Icons.camera_alt,
                                size: 22,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () async {
                                controller.image[8] = await controller
                                    .pickImageGallerys();
                                if (controller.image[8] != null) {
                                  controller.heatingsystem =
                                  await controller.upload(controller.image[8]);
                                }
                              },
                              child: Icon(
                                Icons.image,
                                size: 22,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                for (int i = 0; i <= controller.list.value; i++)
                  CustomProperty(
                      index: i,
                      name: i == 0
                          ? "Front Aspect"
                          : i == 1
                          ? "Entrance Hall"
                          : i == 2
                          ? "Kitchen"
                          : i == 3
                          ? "Lounge 1"
                          : i == 4
                          ? "Bathroom"
                          : i == 5
                          ? "Rear Garden"
                          : i == 6
                          ? "Bathroom 2"
                          : "Bedroom " + i.toString(),
                      data: pd,
                      images: images),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: 10,
                    height: 50,
                    onPressed: () {
                      controller.list.value++;
                    },
                    child: SizedBox(
                      width: 110,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            "Add New",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Asked Landlord to",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.askedLandlordToController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Descriptions"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Advised Tenant to",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.advisedTenantToController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Descriptions"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Final Remarks",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.finalRemarksController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Descriptions"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Inspector\' Signature",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      EasySignaturePad(
                        onChanged: (image) async {
                          Uint8List convertedBytes = base64Decode(image);
                          final tempDir = await getTemporaryDirectory();
                          File file =
                          await File('${tempDir.path}/image.png').create();
                          file.writeAsBytesSync(convertedBytes);
                          controller.inspector = await controller.upload(file);
                        },
                        height: Get.width ~/ 2,
                        width: Get.width ~/ 1,
                        penColor: Colors.black,
                        strokeWidth: 1.0,
                        borderRadius: 10.0,
                        borderColor: Colors.grey,
                        backgroundColor: Colors.white,
                        transparentImage: false,
                        transparentSignaturePad: false,
                        hideClearSignatureIcon: false,
                      ),
                    ]),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tenant\'s Signature",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      EasySignaturePad(
                        onChanged: (image) async {
                          Uint8List convertedBytes = base64Decode(image);
                          final tempDir = await getTemporaryDirectory();
                          File file =
                          await File('${tempDir.path}/image.png').create();
                          file.writeAsBytesSync(convertedBytes);
                          controller.tenant = await controller.upload(file);
                        },
                        height: Get.width ~/ 2,
                        width: Get.width ~/ 1,
                        penColor: Colors.black,
                        strokeWidth: 1.0,
                        borderRadius: 10.0,
                        borderColor: Colors.grey,
                        backgroundColor: Colors.white,
                        transparentImage: false,
                        transparentSignaturePad: false,
                        hideClearSignatureIcon: false,
                      ),
                    ]),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: Get.width,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () {
                    pd = pd.toSet().toList();
                    print(pd[0]);
                    model?.propertyDetails = pd;
                    print(pd.length);
                    controller.updateData(pd,widget.id);

                  },
                  color: Colors.blue,
                  child: Text("Upload Property"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
