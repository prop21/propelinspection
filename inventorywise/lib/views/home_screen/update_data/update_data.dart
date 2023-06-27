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

import '../../../utils/global.dart';
import '../../../widgets/custom_property.dart';

class UpdateDataScreen extends StatefulWidget {
  UpdateDataScreenState createState() => UpdateDataScreenState();
  UpdateDataScreen({this.id, this.data});
  var data;
  String? id;
}

class UpdateDataScreenState extends State<UpdateDataScreen> {
  final controller = Get.put(AddDataController());
  AddPropertyModel? model;
  List<PropertyDetails> pd = [];
  List<List<String>> images = [];
  @override
  Widget build(BuildContext context) {
    model = AddPropertyModel();
    controller.f[0].text = widget.data.propertyAddress;
    controller.f[1].text = widget.data.tenantName;
    controller.f[2].text = widget.data.inspectorName;
    controller.f[3].text = widget.data.inspectionDate;
    controller.f[4].text = widget.data.ecpExpDate;
    controller.f[5].text = widget.data.ecirExpDate;
    controller.f[6].text = widget.data.gasSafetyCertificateExpDate;
    controller.f[7].text = widget.data.electricityMeterReading;
    controller.f[8].text = widget.data.gasMeterReading;
    controller.f[9].text = widget.data.waterMeterReading;
    controller.t1.value = widget.data.electricityMeter;
    controller.t2.value = widget.data.gasMeter;
    controller.t3.value = widget.data.waterMeter;
    controller.t4.value = widget.data.smokeAlarm;
    controller.t5.value = widget.data.coAlarm;
    controller.t6.value = widget.data.heatingSystem;
    controller.askedLandlordToController.text = widget.data.askedLandlordTo;
    controller.advisedTenantToController.text = widget.data.advisedTenantTo;
    controller.finalRemarksController.text = widget.data.finalRemarks;
    controller.list.value = widget.data.propertyDetails.length;
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
                            if (index == 0) {
                              controller.type.value = "Inventory Report";
                            }
                            if (index == 1) {
                              controller.type.value = "Mid Term Inspection";
                            }
                            if (index == 2) {
                              controller.type.value = "Checkout Report";
                            }
                          },
                          child: Text(index == 0
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
                  child: widget.data.mainImg.isNotEmpty ||
                          controller.maini.value.path.isNotEmpty
                      ? Stack(children: [
                          controller.maini.value.path.isNotEmpty
                              ? Image.file(
                                  File(controller.maini.value.path.toString()),
                                  fit: BoxFit.fill,
                                  height: 120,
                                  width: Get.width,
                                )
                              : Image.network(
                                  Paths.baseUrl + "/" + widget.data.mainImg,
                                  fit: BoxFit.fill,
                                  height: 120,
                                  width: Get.width),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 5, top: 5),
                                  child: InkWell(
                                      onTap: () {
                                        controller.maini.value = File("");
                                        widget.data.mainImg = "";
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
                                controller.maini.value =
                                    await controller.pickImages();
                                if (controller.maini.value != null) {
                                  controller.mainimage = await controller
                                      .upload(controller.maini.value);
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
                                controller.maini.value =
                                    await controller.pickImageGallerys();
                                if (controller.maini.value != null) {
                                  controller.mainimage = await controller
                                      .upload(controller.maini.value);
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
                          child: widget.data.electricityMeterImg != null ||
                                  controller.electric.value.path.isNotEmpty
                              ? Stack(children: [
                                  controller.electric.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.electric.value.path
                                              .toString()),
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: Get.width,
                                        )
                                      : Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              widget.data.electricityMeterImg,
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
                                                controller.electric.value =
                                                    File("");
                                                widget.data
                                                    .electricityMeterImg = "";
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
                                        controller.electric.value =
                                            await controller.pickImages();
                                        if (controller.electric.value != null) {
                                          controller.electricmeterfront =
                                              await controller.upload(
                                                  controller.electric.value);
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
                                        controller.electric.value =
                                            await controller
                                                .pickImageGallerys();
                                        if (controller.electric.value != null) {
                                          controller.electricmeterfront =
                                              await controller.upload(
                                                  controller.electric.value);
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
                          child: widget.data.gasMeterImg != null ||
                                  controller.gasmeter.value.path.isNotEmpty
                              ? Stack(children: [
                                  controller.gasmeter.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.gasmeter.value.path
                                              .toString()),
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: Get.width,
                                        )
                                      : Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              widget.data.gasMeterImg
                                                  .toString(),
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
                                                controller.gasmeter.value =
                                                    File("");
                                                widget.data.gasMeterImg = "";
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
                                        controller.gasmeter.value =
                                            await controller.pickImages();
                                        if (controller.gasmeter.value != null) {
                                          controller.gasmeterfront =
                                              await controller.upload(
                                                  controller.gasmeter.value);
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
                                        if (controller.gasmeter.value != null) {
                                          controller.gasmeterfront =
                                              await controller.upload(
                                                  controller.gasmeter.value);
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
                          child: widget.data.waterMeterImg != null ||
                                  controller.watermeter.value.path.isNotEmpty
                              ? Stack(children: [
                                  controller.watermeter.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.watermeter.value.path
                                              .toString()),
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: Get.width,
                                        )
                                      : Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              widget.data.waterMeterImg,
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
                                                controller.watermeter.value =
                                                    File("");
                                                widget.data.waterMeterImg = "";
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
                                        controller.watermeter.value =
                                            await controller.pickImages();
                                        if (controller.watermeter.value !=
                                            null) {
                                          controller.watermeterfront =
                                              await controller.upload(
                                                  controller.watermeter.value);
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
                                        controller.watermeter.value =
                                            await controller
                                                .pickImageGallerys();
                                        if (controller.watermeter.value !=
                                            null) {
                                          controller.watermeterfront =
                                              await controller.upload(
                                                  controller.watermeter.value);
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
                          child: widget.data.smokeAlarmFrontImg != null ||
                                  controller.smokealarm.value.path.isNotEmpty
                              ? Stack(children: [
                                  controller.smokealarm.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.smokealarm.value.path
                                              .toString()),
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: Get.width,
                                        )
                                      : Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              widget.data.smokeAlarmFrontImg,
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
                                                controller.smokealarm.value =
                                                    File("");
                                                widget.data.smokeAlarmFrontImg =
                                                    "";
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
                                        controller.smokealarm.value =
                                            await controller.pickImages();
                                        if (controller.smokealarm.value !=
                                            null) {
                                          controller.smokealarmfront =
                                              await controller.upload(
                                                  controller.smokealarm.value);
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
                                        controller.smokealarm.value =
                                            await controller
                                                .pickImageGallerys();
                                        if (controller.smokealarm.value !=
                                            null) {
                                          controller.smokealarmfront =
                                              await controller.upload(
                                                  controller.smokealarm.value);
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
                          child: widget.data.smokeAlarmBackImg != null ||
                                  controller.smokealar.value.path.isNotEmpty
                              ? Stack(children: [
                                  controller.smokealar.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.smokealar.value.path
                                              .toString()),
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: Get.width,
                                        )
                                      : Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              widget.data.smokeAlarmBackImg,
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
                                                controller.smokealar.value =
                                                    File("");
                                                widget.data.smokeAlarmBackImg =
                                                    "";
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
                                        controller.smokealar.value =
                                            await controller.pickImages();
                                        if (controller.smokealar.value !=
                                            null) {
                                          controller.smokealarmback =
                                              await controller.upload(
                                                  controller.smokealar.value);
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
                                        controller.smokealar.value =
                                            await controller
                                                .pickImageGallerys();
                                        if (controller.smokealar.value !=
                                            null) {
                                          controller.smokealarmback =
                                              await controller.upload(
                                                  controller.smokealar.value);
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
                          child: widget.data.coAlarmFrontImg != null ||
                                  controller.coal.value.path.isNotEmpty
                              ? Stack(children: [
                                  controller.coal.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.coal.value.path
                                              .toString()),
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: Get.width,
                                        )
                                      : Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              widget.data.coAlarmFrontImg,
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
                                                controller.coal.value =
                                                    File("");
                                                widget.data.coAlarmFrontImg =
                                                    "";
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
                                        controller.coal.value =
                                            await controller.pickImages();
                                        if (controller.coal.value != null) {
                                          controller.coalarmfront =
                                              await controller.upload(
                                                  controller.coal.value);
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
                                        controller.coal.value = await controller
                                            .pickImageGallerys();
                                        if (controller.coal.value != null) {
                                          controller.coalarmfront =
                                              await controller.upload(
                                                  controller.coal.value);
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
                          child: widget.data.coAlarmBackImg != null ||
                                  controller.coalarm.value.path.isNotEmpty
                              ? Stack(children: [
                                  controller.coalarm.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.coalarm.value.path
                                              .toString()),
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: Get.width,
                                        )
                                      : Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              widget.data.coAlarmBackImg,
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
                                                controller.coalarm.value =
                                                    File("");
                                                widget.data.coAlarmBackImg = "";
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
                                        controller.coalarm.value =
                                            await controller.pickImages();
                                        if (controller.coalarm.value != null) {
                                          controller.coalarmback =
                                              await controller.upload(
                                                  controller.coalarm.value);
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
                                        controller.coalarm.value =
                                            await controller
                                                .pickImageGallerys();
                                        if (controller.coalarm.value != null) {
                                          controller.coalarmback =
                                              await controller.upload(
                                                  controller.coalarm.value);
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
                        child: widget.data.heatingSystemImg != null ||
                                controller.heating.value.path.isNotEmpty
                            ? Stack(children: [
                                controller.heating.value.path.isNotEmpty
                                    ? Image.file(
                                        File(controller.heating.value.path
                                            .toString()),
                                        fit: BoxFit.fill,
                                        height: 120,
                                        width: Get.width,
                                      )
                                    : Image.network(
                                        Paths.baseUrl +
                                            "/" +
                                            widget.data.heatingSystemImg,
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
                                              controller.heating.value =
                                                  File("");
                                              widget.data.heatingSystemImg = "";
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
                                      controller.heating.value =
                                          await controller.pickImages();
                                      if (controller.heating.value != null) {
                                        controller.heatingsystem =
                                            await controller.upload(
                                                controller.heating.value);
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
                                      controller.heating.value =
                                          await controller.pickImageGallerys();
                                      if (controller.heating.value != null) {
                                        controller.heatingsystem =
                                            await controller.upload(
                                                controller.heating.value);
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
                for (int i = 0; i < widget.data.propertyDetails.length; i++)
                  if (controller.items.contains(i)) ...[
                    CustomProperty1(
                      imgurl: widget.data.propertyDetails[i].propertyImages,
                        walls: widget.data.propertyDetails[i].walls,
                        units: widget.data.propertyDetails[i].units,
                        floor: widget.data.propertyDetails[i].floor,
                        doors: widget.data.propertyDetails[i].doors,
                        windows: widget.data.propertyDetails[i].windows,
                        celling: widget.data.propertyDetails[i].ceiling,
                        appliences: widget.data.propertyDetails[i].appliances,
                        index: i,
                        name: widget.data.propertyDetails[i].name,
                        data: pd,
                        images: images),
                  ],
                // if (controller.items.contains(0)) ...[
                //   CustomProperty(
                //       index: 0,
                //       name: "Front & Side Aspects",
                //       data: pd,
                //       images: images),
                // ],
                // if (controller.items.contains(1)) ...[
                //   CustomProperty(
                //       index: 1,
                //       name: "Entrance Hall",
                //       data: pd,
                //       images: images),
                // ],
                // if (controller.items.contains(2)) ...[
                //   CustomProperty(
                //       index: 2, name: "Kitchen", data: pd, images: images),
                // ],
                // if (controller.items.contains(3)) ...[
                //   CustomProperty(
                //       index: 3, name: "Rear garden", data: pd, images: images),
                // ],
                // if (controller.items.contains(4)) ...[
                //   CustomProperty(
                //       index: 4, name: "Bathroom", data: pd, images: images),
                // ],
                // if (controller.items.contains(5)) ...[
                //   CustomProperty(
                //       index: 5, name: "Bathroom 1", data: pd, images: images),
                // ],
                // if (controller.items.contains(6)) ...[
                //   CustomProperty(
                //       index: 6, name: "Lounge", data: pd, images: images),
                // ],
                // if (controller.items.contains(7)) ...[
                //   CustomProperty(
                //       index: 7, name: "Bedroom", data: pd, images: images),
                // ],
                for (int i = widget.data.propertyDetails.length;
                    i < controller.list.value;
                    i++)
                  CustomProperty(
                      index: i,
                      name: "Bedroom " + (i - 7).toString(),
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
                    model?.propertyDetails = pd;
                    controller.updateData(pd, widget.id);
                  },
                  color: Colors.blue,
                  child: Text("Update Property"),
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
