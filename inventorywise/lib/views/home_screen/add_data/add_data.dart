import 'dart:convert';
import 'dart:typed_data';

import 'package:InventoryWise/models/addproperty/add_proprert_model.dart';
import 'package:InventoryWise/views/home_screen/add_data/add_data_controller.dart';
import 'package:InventoryWise/widgets/custom_loader_widget.dart';

import 'package:easy_signature_pad/easy_signature_pad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../widgets/custom_property.dart';

class AddDataScreen extends StatefulWidget {
  AddDataScreenState createState() => AddDataScreenState();
}

class AddDataScreenState extends State<AddDataScreen> {
  final controller = Get.put(AddDataController());
  AddPropertyModel? model;
  List<PropertyDetails> pd = [];
  List<List<String>> images = [];
  @override
  Widget build(BuildContext context) {
    controller.f[3].text = DateTime.now().toString();
    controller.f[4].text = DateTime.now().toString();
    controller.f[5].text = DateTime.now().toString();
    controller.f[6].text = DateTime.now().toString();
    controller.inspectionDateController.text = DateTime.now().day.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().year.toString();
    controller.epcExpiryDateController.text = DateTime.now().day.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().year.toString();
    controller.ecirExpiryDateController.text = DateTime.now().day.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().year.toString();
    controller.gasSafetyCertificateExpiryDateController.text =
        DateTime.now().day.toString() +
            "-" +
            DateTime.now().month.toString() +
            "-" +
            DateTime.now().year.toString();
    controller.advisedTenantToController.text =
        "To Keep the property clean, tidy and adequately ventilated at all times.";
    model = AddPropertyModel();
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false, // fluter 2.x
      appBar: AppBar(
        title: Text("Add new Property"),
        centerTitle: true,
      ),

      body: Obx(
        () => CustomLoaderWidget(
          isTrue: controller.loading.value,
          child: SingleChildScrollView(
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
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: MaterialButton(
                                height: 35,
                                minWidth: 150,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Colors.black)),
                                color: controller.se.value == index
                                    ? Colors.blue
                                    : Colors.white,
                                onPressed: () {
                                  if (index == 0) {
                                    controller.type.value = "Inventory Report";
                                    controller.se.value = 0;
                                    setState(() {});
                                  }
                                  if (index == 1) {
                                    controller.type.value =
                                        "Mid Term Inspection";
                                    controller.se.value = 1;
                                    setState(() {});
                                  }
                                  if (index == 2) {
                                    controller.type.value = "Checkout Report";
                                    controller.se.value = 2;
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  index == 0
                                      ? "Inventory Report"
                                      : index == 1
                                          ? "Mid Term Inspection"
                                          : "Checkout Report",
                                  style: TextStyle(
                                      color: controller.se.value == index
                                          ? Colors.white
                                          : Colors.black),
                                ),
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 50, right: 50),
                      height: 120,
                      width: controller.maini.value.path.isNotEmpty
                          ? 160
                          : Get.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: controller.maini.value.path.isNotEmpty
                          ? Stack(children: [
                              Image.file(
                                File(controller.maini.value.path.toString()),
                                fit: BoxFit.cover,
                                height: 120,
                                width: Get.width,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5, top: 5),
                                  child: InkWell(
                                    onTap: () {
                                      controller.maini.value = File("");
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
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
                                    await Gal.putImage(
                                        controller.maini.value.path);
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
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    "Property Address",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      controller.f[3].text = pickedDate.toString();
                      controller.inspectionDateController.text =
                          pickedDate!.day.toString() +
                              "-" +
                              pickedDate.month.toString() +
                              "-" +
                              pickedDate.year.toString();
                    },
                    child: TextField(
                      enabled: false,
                      controller: controller.inspectionDateController,
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      controller.f[4].text = pickedDate.toString();
                      controller.epcExpiryDateController.text =
                          pickedDate!.day.toString() +
                              "-" +
                              pickedDate.month.toString() +
                              "-" +
                              pickedDate.year.toString();
                    },
                    child: TextField(
                      enabled: false,
                      controller: controller.epcExpiryDateController,
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      controller.f[5].text = pickedDate.toString();
                      controller.ecirExpiryDateController.text =
                          pickedDate!.day.toString() +
                              "-" +
                              pickedDate.month.toString() +
                              "-" +
                              pickedDate.year.toString();
                    },
                    child: TextField(
                      enabled: false,
                      controller: controller.ecirExpiryDateController,
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
                    "Gas Safety Certificate Expiry Date",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      controller.f[6].text = pickedDate.toString();
                      controller.gasSafetyCertificateExpiryDateController.text =
                          pickedDate!.day.toString() +
                              "-" +
                              pickedDate.month.toString() +
                              "-" +
                              pickedDate.year.toString();
                    },
                    child: TextField(
                      enabled: false,
                      controller:
                          controller.gasSafetyCertificateExpiryDateController,
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
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                              fontSize: 16),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: (Get.width / 2) - 50,
                          child: Text(
                            "   Reading",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: 16),
                          ),
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
                              controller.t1.value = "Yes";
                            },
                            minWidth: 80,
                            color: controller.t1.value == "Yes"
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
                            color: controller.t1.value == "No"
                                ? Colors.blue
                                : Colors.white,
                            onPressed: () {
                              controller.t1.value = "No";
                            },
                            child: Text("No"),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 25,
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 70,
                              height: 35,
                              child: TextField(
                                controller: controller.f[7],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    bottom: 12, // HERE THE IMPORTANT PART
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue, //<-- SEE HERE
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: 38,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: controller.electric.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.electric.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.electric.value =
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
                                            controller.electric.value =
                                                await controller.pickImages();
                                            if (controller.electric.value !=
                                                null) {
                                              controller.electricmeterfront =
                                                  await controller.upload(
                                                      controller
                                                          .electric.value);
                                            }
                                            await Gal.putImage(
                                                controller.electric.value.path);
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
                                            if (controller.electric.value !=
                                                null) {
                                              controller.electricmeterfront =
                                                  await controller.upload(
                                                      controller
                                                          .electric.value);
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
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                              fontSize: 16),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: (Get.width / 2) - 50,
                          child: Text(
                            "   Reading",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: 16),
                          ),
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
                              controller.t2.value = "Yes";
                            },
                            minWidth: 80,
                            color: controller.t2.value == "Yes"
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
                            color: controller.t2.value == "No"
                                ? Colors.blue
                                : Colors.white,
                            onPressed: () {
                              controller.t2.value = "No";
                            },
                            child: Text("No"),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 25,
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 70,
                              height: 35,
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: controller.f[8],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    bottom: 12, // HERE THE IMPORTANT PART
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue, //<-- SEE HERE
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: 38,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: controller.gasmeter.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.gasmeter.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.gasmeter.value =
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
                                            controller.gasmeter.value =
                                                await controller.pickImages();
                                            if (controller.gasmeter.value !=
                                                null) {
                                              controller.gasmeterfront =
                                                  await controller.upload(
                                                      controller
                                                          .gasmeter.value);
                                            }
                                            await Gal.putImage(
                                                controller.gasmeter.value.path);
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
                                            controller.gasmeter.value =
                                                await controller
                                                    .pickImageGallerys();
                                            if (controller.gasmeter.value !=
                                                null) {
                                              controller.gasmeterfront =
                                                  await controller.upload(
                                                      controller
                                                          .gasmeter.value);
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
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                              fontSize: 16),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: (Get.width / 2) - 50,
                          child: Text(
                            "   Reading",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: 16),
                          ),
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
                              controller.t3.value = "Yes";
                            },
                            minWidth: 80,
                            color: controller.t3.value == "Yes"
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
                            color: controller.t3.value == "No"
                                ? Colors.blue
                                : Colors.white,
                            onPressed: () {
                              controller.t3.value = "No";
                            },
                            child: Text("No"),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 25,
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 70,
                              height: 35,
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: controller.f[9],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    bottom: 12, // HERE THE IMPORTANT PART
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue, //<-- SEE HERE
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: 38,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: controller.watermeter.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.watermeter.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.watermeter
                                                        .value = File("");
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )))),
                                    ])
                                  : controller.watermeter.value.path.isNotEmpty
                                      ? Stack(children: [
                                          Image.file(
                                            File(controller
                                                .watermeter.value.path
                                                .toString()),
                                            fit: BoxFit.contain,
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
                                                        controller.watermeter
                                                            .value = File("");
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
                                                controller.watermeter.value =
                                                    await controller
                                                        .pickImages();
                                                if (controller
                                                        .watermeter.value !=
                                                    null) {
                                                  controller.watermeterfront =
                                                      await controller.upload(
                                                          controller.watermeter
                                                              .value);
                                                }
                                                await Gal.putImage(controller
                                                    .watermeter.value.path);
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
                                                if (controller
                                                        .watermeter.value !=
                                                    null) {
                                                  controller.watermeterfront =
                                                      await controller.upload(
                                                          controller.watermeter
                                                              .value);
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
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                              fontSize: 16),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: (Get.width / 2) - 50,
                          child: Text(
                            "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: 16),
                          ),
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
                              controller.t4.value = "Yes";
                            },
                            minWidth: 80,
                            color: controller.t4.value == "Yes"
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
                            color: controller.t4.value == "No"
                                ? Colors.blue
                                : Colors.white,
                            onPressed: () {
                              controller.t4.value = "No";
                            },
                            child: Text("No"),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 25,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 38,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: controller.smokealarm.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.smokealarm.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.smokealarm
                                                        .value = File("");
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )))),
                                    ])
                                  : controller.smokealarm.value.path.isNotEmpty
                                      ? Stack(children: [
                                          Image.file(
                                            File(controller
                                                .smokealarm.value.path
                                                .toString()),
                                            fit: BoxFit.contain,
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
                                                        controller.smokealarm
                                                            .value = File("");
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
                                                controller.smokealarm.value =
                                                    await controller
                                                        .pickImages();
                                                if (controller
                                                        .smokealarm.value !=
                                                    null) {
                                                  controller.smokealarmfront =
                                                      await controller.upload(
                                                          controller.smokealarm
                                                              .value);
                                                }
                                                await Gal.putImage(controller
                                                    .smokealarm.value.path);
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
                                                if (controller
                                                        .smokealarm.value !=
                                                    null) {
                                                  controller.smokealarmfront =
                                                      await controller.upload(
                                                          controller.smokealarm
                                                              .value);
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: 38,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: controller.smokealar.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.smokealar.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.smokealar.value =
                                                        File("");
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )))),
                                    ])
                                  : controller.smokealar.value.path.isNotEmpty
                                      ? Stack(children: [
                                          Image.file(
                                            File(controller.smokealar.value.path
                                                .toString()),
                                            fit: BoxFit.contain,
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
                                                        controller.smokealar
                                                            .value = File("");
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
                                                controller.smokealar.value =
                                                    await controller
                                                        .pickImages();
                                                if (controller
                                                        .smokealar.value !=
                                                    null) {
                                                  controller.smokealarmback =
                                                      await controller.upload(
                                                          controller
                                                              .smokealar.value);
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
                                                if (controller
                                                        .smokealar.value !=
                                                    null) {
                                                  controller.smokealarmback =
                                                      await controller.upload(
                                                          controller
                                                              .smokealar.value);
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
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                              fontSize: 16),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: (Get.width / 2) - 50,
                          child: Text(
                            "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: 16),
                          ),
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
                              controller.t5.value = "Yes";
                            },
                            minWidth: 80,
                            color: controller.t5.value == "Yes"
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
                            color: controller.t5.value == "No"
                                ? Colors.blue
                                : Colors.white,
                            onPressed: () {
                              controller.t5.value = "No";
                            },
                            child: Text("No"),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 25,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 38,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: controller.coal.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.coal.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.coal.value =
                                                        File("");
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )))),
                                    ])
                                  : controller.coal.value.path.isNotEmpty
                                      ? Stack(children: [
                                          Image.file(
                                            File(controller.coal.value.path
                                                .toString()),
                                            fit: BoxFit.contain,
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
                                                        controller.coal.value =
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
                                                controller.coal.value =
                                                    await controller
                                                        .pickImages();
                                                if (controller.coal.value !=
                                                    null) {
                                                  controller.coalarmfront =
                                                      await controller.upload(
                                                          controller
                                                              .coal.value);
                                                }
                                                await Gal.putImage(
                                                    controller.coal.value.path);
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
                                                controller.coal.value =
                                                    await controller
                                                        .pickImageGallerys();
                                                if (controller.coal.value !=
                                                    null) {
                                                  controller.coalarmfront =
                                                      await controller.upload(
                                                          controller
                                                              .coal.value);
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: 38,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: controller.coalarm.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.coalarm.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.coalarm.value =
                                                        File("");
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )))),
                                    ])
                                  : controller.coalarm.value.path.isNotEmpty
                                      ? Stack(children: [
                                          Image.file(
                                            File(controller.coalarm.value.path
                                                .toString()),
                                            fit: BoxFit.contain,
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
                                                        controller.coalarm
                                                            .value = File("");
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
                                                controller.coalarm.value =
                                                    await controller
                                                        .pickImages();
                                                if (controller.coalarm.value !=
                                                    null) {
                                                  controller.coalarmback =
                                                      await controller.upload(
                                                          controller
                                                              .coalarm.value);
                                                }
                                                await Gal.putImage(controller
                                                    .coalarm.value.path);
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
                                                if (controller.coalarm.value !=
                                                    null) {
                                                  controller.coalarmback =
                                                      await controller.upload(
                                                          controller
                                                              .coalarm.value);
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
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                              fontSize: 16),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: (Get.width / 2) - 50,
                          child: Text(
                            "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: 16),
                          ),
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
                            controller.t6.value = "Yes";
                          },
                          minWidth: 80,
                          color: controller.t6.value == "Yes"
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
                          color: controller.t6.value == "No"
                              ? Colors.blue
                              : Colors.white,
                          onPressed: () {
                            controller.t6.value = "No";
                          },
                          child: Text("No"),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 25,
                          ),
                        ),
                        Container(
                          height: 38,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: controller.heating.value.path.isNotEmpty
                              ? Stack(children: [
                                  Image.file(
                                    File(controller.heating.value.path
                                        .toString()),
                                    fit: BoxFit.contain,
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
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )))),
                                ])
                              : controller.heating.value.path.isNotEmpty
                                  ? Stack(children: [
                                      Image.file(
                                        File(controller.heating.value.path
                                            .toString()),
                                        fit: BoxFit.contain,
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
                                                    controller.heating.value =
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
                                            controller.heating.value =
                                                await controller.pickImages();
                                            if (controller.heating.value !=
                                                null) {
                                              controller.heatingsystem =
                                                  await controller.upload(
                                                      controller.heating.value);
                                            }
                                            await Gal.putImage(
                                                controller.heating.value.path);
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
                                                await controller
                                                    .pickImageGallerys();
                                            if (controller.heating.value !=
                                                null) {
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
                  if (controller.items.contains(0)) ...[
                    CustomProperty(
                        index: 0,
                        name: "Front & Side Aspects",
                        data: pd,
                        images: images),
                  ],
                  if (controller.items.contains(1)) ...[
                    CustomProperty(
                        index: 1,
                        name: "Entrance Hall",
                        data: pd,
                        images: images),
                  ],
                  if (controller.items.contains(2)) ...[
                    CustomProperty(
                        index: 2,
                        name: "Living Room 1",
                        data: pd,
                        images: images),
                  ],
                  if (controller.items.contains(3)) ...[
                    CustomProperty(
                        index: 3,
                        name: "Living Room 2",
                        data: pd,
                        images: images),
                  ],
                  if (controller.items.contains(4)) ...[
                    CustomProperty(
                        index: 4, name: "Kitchen", data: pd, images: images),
                  ],
                  if (controller.items.contains(5)) ...[
                    CustomProperty(
                        index: 5,
                        name: "Rear Garden",
                        data: pd,
                        images: images),
                  ],
                  if (controller.items.contains(6)) ...[
                    CustomProperty(
                        index: 6, name: "Landing", data: pd, images: images),
                  ],
                  if (controller.items.contains(7)) ...[
                    CustomProperty(
                        index: 7, name: "Bedroom 1", data: pd, images: images),
                  ],
                  if (controller.items.contains(8)) ...[
                    CustomProperty(
                        index: 8, name: "Bedroom 2", data: pd, images: images),
                  ],
                  if (controller.items.contains(9)) ...[
                    CustomProperty(
                        index: 9, name: "Bedroom 3", data: pd, images: images),
                  ],
                  if (controller.items.contains(10)) ...[
                    CustomProperty(
                        index: 10, name: "Bedroom 4", data: pd, images: images),
                  ],
                  if (controller.items.contains(11)) ...[
                    CustomProperty(
                        index: 11, name: "Bedroom 5", data: pd, images: images),
                  ],
                  if (controller.items.contains(12)) ...[
                    CustomProperty(
                        index: 12,
                        name: "Bathroom 1",
                        data: pd,
                        images: images),
                  ],
                  if (controller.items.contains(13)) ...[
                    CustomProperty(
                        index: 13,
                        name: "Bathroom 2",
                        data: pd,
                        images: images),
                  ],
                  for (int i = controller.te.value;
                      i < controller.list.value;
                      i++)
                    CustomProperty(
                        index: i,
                        name: "Room " +
                            (controller.list.value - (controller.te.value))
                                .toString(),
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
                        // controller.te.value++;
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      controller.bottomSheet(controller.sig1.value);
                    },
                    child: Container(
                        height: 200,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: controller.sig1.value.existsSync()
                            ? Image.file(controller.sig1.value, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                                return Text('');
                              })
                            : SizedBox()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tenant\'s Signature",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      controller.bottomSheet1(controller.sig2.value);
                    },
                    child: Container(
                        height: 200,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: controller.sig2.value.existsSync()
                            ? Image.file(controller.sig2.value, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                                return Text('');
                              })
                            : SizedBox()),
                  ),
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
                      print(model?.propertyDetails?.length);
                      controller.addData(model?.propertyDetails);
                    },
                    color: Colors.blue,
                    child: Text(
                      "Upload Property",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
