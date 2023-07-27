import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:InventoryWise/views/home_screen/add_data/add_data_controller.dart';
import 'package:InventoryWise/views/home_screen/show_data/showdata_controller.dart';
import 'package:InventoryWise/views/home_screen/update_data/update_data.dart';
import 'package:InventoryWise/widgets/custom_loader_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/addproperty/add_proprert_model.dart' as pp;

import '../../../models/homedata/Home_Data.dart';
import '../../../utils/global.dart';

class Show_Data_Screen extends StatelessWidget {
  Show_Data_Screen({this.data, this.email});
  Rows? data;
  Rows? temp;
  String? email;
  final controller = Get.put(ShowDataController());
  String decodedString = "";
  String decodedString1 = "";
  @override
  Widget build(BuildContext context) {
    List<PropertyDetails> propertyList = [];
    List<pp.PropertyDetails> propertyL = [];
    controller.isLoading.value = true;
    for (int i = 0; i < data!.propertyDetails!.length; i++) {
      propertyList.add(data!.propertyDetails![i]);
      print(data!.propertyDetails?[i].name);
      List<String>? im = [];
      data?.propertyDetails![i].propertyImages?.forEach((element) {
        im.add(element.url.toString());
      });
      propertyL.add(pp.PropertyDetails(
          name: data?.propertyDetails?[i].name,
          description: data?.propertyDetails?[i].description,
          floor: data?.propertyDetails?[i].floor,
          walls: data?.propertyDetails?[i].walls,
          ceiling: data?.propertyDetails?[i].ceiling,
          windows: data?.propertyDetails?[i].windows,
          doors: data?.propertyDetails?[i].doors,
          units: data?.propertyDetails?[i].units,
          appliances: data?.propertyDetails?[i].appliances,
          images: im));
    }

    controller.isLoading.value = false;

    if (data?.signatureTenant != null && data?.signatureInspector != null) {
      final Uint8List bytes = Uint8List.fromList(data!.signatureTenant!.data!);
      String base64Image = base64Encode(bytes);
      decodedString = utf8.decode(base64Decode(base64Image));
      final Uint8List bytes1 =
          Uint8List.fromList(data!.signatureInspector!.data!);
      String base64Image1 = base64Encode(bytes1);
      decodedString1 = utf8.decode(base64Decode(base64Image1));
    }
    print(data?.id);
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false, // fluter 2.x
      appBar: AppBar(
        title: Text("Property Details"),
        centerTitle: true,
      ),

      body: Obx(
        () => CustomLoaderWidget(
          isTrue: controller.isLoading.value,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2)),
                      height: 60,
                      width: 200,
                      child: Text(
                        (data?.types.toString()).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    data!.propertyAddress.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    height: 200,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 3, color: Colors.grey),
                    ),
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                      elevation: 18,
                      shadowColor: Colors.black,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          Paths.baseUrl + "/" + data!.mainImg.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(() => UpdateDataScreen(
                                    id: data?.id.toString(),
                                    data: data,
                                    sorted: propertyL,
                                    tenet: decodedString,
                                    inspector: decodedString1,
                                  ));
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Delete Property',
                                desc: 'Do you want to delete this property?',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  controller.deleteData(data?.id.toString());
                                },
                              )..show();
                            },
                            child: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Inspection Date:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Text(
                        DateTime.parse(data!.inspectionDate.toString())
                                .day
                                .toString() +
                            "-" +
                            DateTime.parse(data!.inspectionDate.toString())
                                .month
                                .toString() +
                            "-" +
                            DateTime.parse(data!.inspectionDate.toString())
                                .year
                                .toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Inspection By:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Text(
                        data!.inspectorName.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Tenant Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Text(
                        data!.tenantName.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 70,
                  //       child: Text(
                  //         "ECP Date:           ",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, color: Colors.blue),
                  //       ),
                  //     ),
                  //     Text(
                  //       DateTime.parse((data?.ecpExpDate).toString())
                  //               .day
                  //               .toString() +
                  //           "-" +
                  //           DateTime.parse((data?.ecpExpDate).toString())
                  //               .month
                  //               .toString() +
                  //           "-" +
                  //           DateTime.parse((data?.ecpExpDate).toString())
                  //               .year
                  //               .toString(),
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //   ],
                  // ),
                  // Divider(
                  //   thickness: 1.5,
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 80,
                  //       child: Text(
                  //         "ECIR Date:         ",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, color: Colors.blue),
                  //       ),
                  //     ),
                  //     Text(
                  //       DateTime.parse(data!.ecirExpDate.toString())
                  //               .day
                  //               .toString() +
                  //           "-" +
                  //           DateTime.parse(data!.ecirExpDate.toString())
                  //               .month
                  //               .toString() +
                  //           "-" +
                  //           DateTime.parse(data!.ecirExpDate.toString())
                  //               .year
                  //               .toString(),
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     )
                  //   ],
                  // ),
                  // Divider(
                  //   thickness: 1.5,
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //         width: 250,
                  //         child: Text(
                  //           "Gas Saftey Certificate Exipiry Date:",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.blue),
                  //         )),
                  //     Text(
                  //       DateTime.parse(data!.gasSafetyCertificateExpDate
                  //                   .toString())
                  //               .day
                  //               .toString() +
                  //           "-" +
                  //           DateTime.parse(data!.gasSafetyCertificateExpDate
                  //                   .toString())
                  //               .month
                  //               .toString() +
                  //           "-" +
                  //           DateTime.parse(data!.gasSafetyCertificateExpDate
                  //                   .toString())
                  //               .year
                  //               .toString(),
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     )
                  //   ],
                  // ),
                  // Divider(
                  //   thickness: 1.5,
                  // ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Pre-Paid Gas Meter:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: data!.gasMeter.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Reading:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              data!.gasMeterReading.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Image.network(
                            Paths.baseUrl + "/" + data!.gasMeterImg.toString(),
                            height: 120,
                            width: Get.width,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Pre-Paid Electricity Meter:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              data!.electricityMeter.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Reading:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: data!.electricityMeterReading
                                              .toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Image.network(
                            Paths.baseUrl +
                                "/" +
                                data!.electricityMeterImg.toString(),
                            height: 120,
                            width: Get.width,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Water Meter:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: data!.waterMeter.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Reading:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: data!.waterMeterReading
                                              .toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Image.network(
                            Paths.baseUrl +
                                "/" +
                                data!.waterMeterImg.toString(),
                            height: 120,
                            width: Get.width,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Smoke Alarm:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: data!.smokeAlarm.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              // Flexible(
                              //   child: Text(
                              //     "Reading:",
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.blue),
                              //   ),
                              // ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Image.network(
                            Paths.baseUrl +
                                "/" +
                                data!.smokeAlarmFrontImg.toString(),
                            height: 120,
                            width: Get.width,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "CO Alarm:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: data!.coAlarm.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Image.network(
                            Paths.baseUrl +
                                "/" +
                                data!.coAlarmFrontImg.toString(),
                            height: 120,
                            width: Get.width,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Heating System Working:",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: data!.heatingSystem.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                          ),
                                        )
                                      ]),
                                ),
                              ),

                              // Flexible(
                              //     child: Text(
                              //   "Reading:",
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.blue),
                              // )),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Image.network(
                            Paths.baseUrl +
                                "/" +
                                data!.heatingSystemImg.toString(),
                            height: 120,
                            width: Get.width,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45.0,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data?.propertyDetails?.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        margin: EdgeInsets.only(left: 10),
                        child: MaterialButton(
                          height: 45,
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          color: controller.value.value == index
                              ? Colors.blue
                              : Colors.white,
                          onPressed: () {
                            controller.value.value = index;
                          },
                          child: Text(
                            (data?.propertyDetails![index].name.toString())
                                .toString(),
                            style: TextStyle(
                                color: controller.value.value == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyList[controller.value.toInt()]
                                    .name
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Walls: ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: propertyList[controller.value.toInt()]
                                        .walls
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                        fontSize: 14),
                                  )
                                ]),
                          ),
                          if (propertyList[controller.value.toInt()]
                                      .name
                                      .toString() !=
                                  "Rear Garden" &&
                              propertyList[controller.value.toInt()]
                                      .name
                                      .toString() !=
                                  "Front \& Side Aspects") ...[
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Ceilings: ",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          propertyList[controller.value.toInt()]
                                                      .ceiling !=
                                                  null
                                              ? propertyList[
                                                      controller.value.toInt()]
                                                  .ceiling
                                                  .toString()
                                              : "",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color,
                                          fontSize: 14),
                                    )
                                  ]),
                            ),
                          ],
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Windows: ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: propertyList[controller.value.toInt()]
                                        .windows
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                        fontSize: 14),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (propertyList[controller.value.toInt()].name ==
                              "Kitchen") ...[
                            RichText(
                              text: TextSpan(
                                  text: "Appliances: ",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          propertyList[controller.value.toInt()]
                                              .appliances
                                              .toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color,
                                          fontSize: 14),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Units: ",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          propertyList[controller.value.toInt()]
                                              .units
                                              .toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color,
                                          fontSize: 14),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                          RichText(
                            text: TextSpan(
                                text: "Floor: ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: propertyList[controller.value.toInt()]
                                        .floor
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                        fontSize: 14),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Doors: ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: propertyList[controller.value.toInt()]
                                        .doors
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                        fontSize: 14),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Details: ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: propertyList[controller.value.toInt()]
                                        .description
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                        fontSize: 14),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Images",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Wrap(
                              runSpacing: 20,
                              spacing: 6,
                              children: [
                                for (int i = 0;
                                    i <
                                        propertyList[controller.value.toInt()]
                                            .propertyImages!
                                            .length;
                                    i++)
                                  if (propertyList[controller.value.toInt()]
                                      .propertyImages![i]
                                      .url!
                                      .contains("upload")) ...[
                                    Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 2)),
                                        child: Image.network(
                                          Paths.baseUrl +
                                              "/" +
                                              propertyList[
                                                      controller.value.toInt()]
                                                  .propertyImages![i]
                                                  .url
                                                  .toString(),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )),
                                  ]
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Advice For Tenant:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Text(data!.advisedTenantTo.toString())),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Advice For Landlord:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Text(data!.askedLandlordTo.toString())),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Summary:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Text(data!.finalRemarks.toString())),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Tenant\ Signature",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(data!.tenantName.toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Image.network(
                                  Paths.baseUrl + "/" + decodedString),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "Inspector\ Signature",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(data!.inspectorName.toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Image.network(
                                  Paths.baseUrl + "/" + decodedString1),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        controller.isLoading.value = true;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var lo = await prefs.getString("logo").toString();
                        print(lo);
                        print(data?.coAlarmFrontImg);
                        var em = await prefs.getString("email").toString();
                        var cem = await prefs.getString("cemail").toString();
                        var cmob = await prefs.getString("cmobile").toString();
                        var cadd = await prefs.getString("caddress").toString();
                        var cname = await prefs.getString("cname").toString();
                        final htmlContent = """
                      <!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Report Title</title>
  </head>

  <style>
   .image-container {
      display: flex;
      justify-content: center;
      justify-items: center;

      flex-wrap: wrap;
      gap: 4px;
    }
    table,
    td,
    th {
      border-bottom:1px solid black;
    }
.image-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px; /* Adjust the gap as per your requirements */
}

.image-container img {
  width: 100%;
  height: auto;
  border-style: solid;
  border-color: grey;
}

    
@media print {
   body {
      -webkit-print-color-adjust: exact;
   }
   table {
      border-collapse: collapse;
      border: 1px solid black;
      width: 30%;
    }
td,
th{
border-bottom:1px solid black;
padding-left: 30px;
}
    #customers {
      font-family: Arial, Helvetica, sans-serif;
      border-collapse: collapse;
      width: 100%;
      background-color: #FFFFFF !important;
      
    }

    #customers td,
    #customers th {
      border: 1px solid #ddd;
      padding: 8px;
      color:black;
      background-color: #FFFFFF !important;
    }
   #customers tr:nth-child(even) {
      background-color: #03a5fc !important;
    }

    #customers tr:hover {
      background-color: #ddd;
    }

    #customers th {
      padding-top: 12px;
      padding-bottom: 12px;
      text-align: left;
      background-color: #03a5fc !important;
      color: white;
    }
}
    
  </style>

  <body>
    <header>
      <div class="header-container">
        <div
          style="
            display: flex;
            margin-left: 20px;
            margin-right: 20px;
            justify-content: space-between;
          "
        >
          <div>
            <img
              style="width: 230px; height: 100px; object-fit: contain;"
              src="${Paths.baseUrl + "/" + lo.toString()}"
              alt="Logo"
            />
          </div>
          <div style="margin-top: 20px;margin-right: 20px;">
            <div style="display: flex; gap: 6px">
              <div style="color: #03a5fc; font-size: 14px; font-weight: bold";>
                Company:
              </div>
              <div style="color: black; font-size: 12px; padding-top: 1px;"; >${cname}</div>
            </div>

            <div style="display: flex; gap: 6px">
              <div style="color: #03a5fc; font-size: 14px; font-weight: bold">
                Address:
              </div>
              <div style="color: black; font-size: 12px; padding-top: 2px;">  &ensp; ${cadd.toString()}</div>
            </div>

            <div style="display: flex; gap: 6px">
              <div style="color: #03a5fc; font-size: 14px; font-weight: bold">
                Phone:
              </div>
              <div style="color: black; font-size: 12px;padding-top: 3px;"> &ensp;&ensp;&ensp; ${cmob}</div>
            </div>
            <div style="display: flex; gap: 6px">
              <div style="color: #03a5fc; font-size: 14px; font-weight: bold">
                Email:
              </div>
              <div style="color: black; font-size: 12px; padding-top: 2px;">&ensp;&ensp;&ensp;&ensp;${cem}</div>
            </div>
          </div>
        </div>
      </div>
    </header>
    <div
      style="
        font-size: 28px;
        text-align: center;
        color: white;
        border-radius: 14px;
        border-color: black;
        padding-top: 10px;
        padding-bottom: 10px;
        border: 10px;
        margin-left: 200px;
        margin-right: 200px;
        margin-top:20px;
        margin-bottom:20px;
        border-style: solid;
        border-width: medium;
        font-weight: bold;
        border-color: black;
        background-color: #03a5fc;
      "
    >
      ${data?.types}
    </div>
    <div
      style="
        font-size: 20px;
        color: black;
        margin-bottom:20px;
        text-align: center;
        font-weight: bold;
      "
    >
      ${data?.propertyAddress}
    </div>
    <div style="display: flex; justify-content: center; align-items: center">
      <img style="border-radius: 12px; border: 5px solid gray; height: 250px; object-fit: contain;" src="${Paths.baseUrl + '/' + data!.mainImg.toString()}" alt="s1"/>
    </div>
    <div
      style="
        display: flex;
        align-items: center;
        justify-content: center;
        margin-top: 30px;
      "
    >
      <table style="width:70%">
        <tr>
          <td
            style="
              font-size: 14px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
              width:50%
            "
          >
            Inspected By
          </td>
          <td
            style="
              font-size: 14px;
              padding-top: 8px;
              padding-bottom: 8px;
              font-weight: 300;
              width:80%
            "
          >
            ${data?.inspectorName}
          </td>
        </tr>
        <tr>
          <td
            style="
              font-size: 14px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            Tenants Name
          </td>
          <td style="font-size: 14px; padding-top: 8px; padding-bottom: 8px">
            ${data?.tenantName}
          </td>
        </tr>
        <tr>
          <td
            style="
              font-size: 14px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            Date of Inspection
          </td>
          <td style="font-size: 14px; padding-top: 8px; padding-bottom: 8px">
            ${DateTime.parse(data!.inspectionDate.toString()).day.toString() + "-" + DateTime.parse(data!.inspectionDate.toString()).month.toString() + "-" + DateTime.parse(data!.inspectionDate.toString()).year.toString()}
          </td>
        </tr>
        
       
      </table>
    </div>
   
    <div
      style="
        font-size: 20px;
        color: #03a5fc;
        margin-left: 36px;
         text-align: center;
        font-weight: bold;
        margin-top: 20px;
      "
    >
      Summary
    </div>
    <div
      style="
        height: 45px;
        margin-top: 10px;
        border: 1px solid black;
        border-radius: 14px;
        font-size: 14px;
        margin-left: 36px;
        padding-left: 15px;
        padding-top: 15px;
        margin-right: 36px;
      "
    >${data?.finalRemarks}</div>
    <br>
    <br>
     <br>
    <br> <br>
    <br> 
    <br> <br>
    <br> 
    <br> 
    <br>
    <br> 
    <br> 
    <br>
    <br> 
    
   
   
    <div
      style="
        font-size: 18px;
        color: #03a5fc;
        margin-left: 48px;
         text-align: center;
        font-weight: bold;
        margin-top: 10px;

      "
    >
      Important Information
    </div>
    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      What is an Inventory Check-In Report?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      The Inventory Check-In Report provides a fair, objective and impartial
      record of the general condition of the contents of the Property as well as
      its internal condition at the outset of the lease of the Property.
    </div>


    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      What are the benefits of using this Report?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      The importance of a professional inventory and statement of condition
      cannot be underestimated. Government advice indicates that Inventories and
      statements of condition are 'strongly recommended' as a means to reduce
      dispute about the deposit at the end of a tenancy. It is in the Tenant's
      interests to carefully check this Inventory Check-In Report and to
      highlight any discrepancies as soon as possible and in any event no later
      than five working days after this Inventory Check-In Report is completed.
      Any outstanding discrepancies found at the end of the tenancy will be
      highlighted in an Inventory Outgoing Report and may affect the retention
      or release of a tenancy deposit.
    </div>

    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      Is the report aimed at the landlord or the tenant?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      The Inventory Check-In Report is objective and contains photographic
      evidence, it may be relied upon and used by the Landlord, the Tenant and
      Letting Agent.
    </div>

    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      What does this Report tell you?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      The Inventory Check-In Report provides a clear and easy to follow
      statement of condition for each of the main elements of the property on a
      room by room basis, together with its contents if appropriate. This report
      comments on and highlights defects or aspects of poor condition that have
      been identified by the Inventory Clerk. Defects in condition will either
      be described in the narrative of the report or evidenced in the
      photographs included in the report. Please Note: where no comment on the
      condition of an element or item of contents is made by the Inventory
      Clerk, the element or item is taken to be in good condition and without
      defect.
    </div>

    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      What does the report not tell you?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      Whilst every effort is made to ensure objectivity and accuracy, the
      Inventory Check-In Report provides no guarantee of the adequacy,
      compliance with standards or safety of any contents or equipment. The
      report will provide a record that such items exist in the property as at
      the date of the Inventory Check-In Report and the superficial condition of
      same. The report is not a building survey, a structural survey or a
      valuation, will not necessarily mention structural defects and does not
      give any advice on the cost of any repair work, or the types of repair
      which should be used.
    </div>

    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      What is inspected and not inspected?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      The Inventory Clerk carries out a visual inspection of the inside of the
      main building together with any contents and will carry out a general
      inspection of the remainder of the building including the exterior
      cosmetic elements and any permanent outbuildings. For properties let on an
      unfurnished basis, the inspection will include floor coverings, curtains,
      curtain tracks, blinds and kitchen appliances if appropriate, but will
      exclude other contents. Gardens and their contents will be inspected and
      reported upon. The inspection is non-invasive. The means that the
      Inventory Clerk does not take up carpets, floor coverings or floor boards,
      move large items of furniture, test services, remove secured panels or
      undo electrical fittings. Especially valuable contents such as antiques,
      personal items or items of jewellery are excluded from the report.
      Kitchenware will be inspected but individual items will not be condition
      rated. Common parts in relation to flats, exterior structural elements of
      the main building and the structure of any outbuildings will not be
      inspected. Roof spaces and cellars are not inspected. Areas which are
      locked or where full access is not possible, for example, attics or
      excessively full cupboards or outbuildings are not inspected.
    </div>
    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      What is a Mid-Term Inspection Report?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      The Mid-Term Inspection Report provides a fair, objective and impartial
      record of the general condition of the contents of the Property as well as
      its internal condition during the lease of the Property. Any defects and
      maintenance issues noted during the inspection are highlighted in the
      report. The tenants are required to rectify the issues which come under
      their obligations as per the terms & conditions of the tenancy agreement.
      Similarly, the landlord of the property will be asked to deal with the
      maintenance issues accordingly.
    </div>

    <div
      style="
        font-size: 14px;
        color: black;
        font-weight: bold;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 12px;
      "
    >
      What is a Check-Out Report?
    </div>
    <div
      style="
        font-size: 12px;
        font-weight: 500;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 10px;
      "
    >
      The Check-Out Report provides a fair, objective and impartial record of
      the general condition of the contents of the Property as well as its
      internal condition at the end of the lease of the Property. Normally, the
      return of the tenancy deposit is based on the outcome of the Check- Out
      report.
    </div>  
 <br>
 <br>
 <br>
    <br>
 <br>
    
    
  
   
    
   

    
    <div
      style="
        font-size: 16px;
        color: #03a5fc;
        margin-left: 50px;
        font-weight: bold;
        margin-top: 6px;
      "
    >
      Meters and Alarms
    </div>

    <div
      style="
        display: flex;
        margin-left: 48px;
        margin-top: 10px;
        margin-right: 48px;
        justify-items: center;
        justify-content: center;
        align-items: center;
        gap: 35px;
      "
    >
       <div
        style="
          width: 510px;
          height: 260px;

          border: 4px solid rgb(207, 206, 206);
          border-radius: 14px;
        "
      >
        <div
          style="
            display: flex;
            justify-content: space-between;
            margin-left: 24px;
            margin-right: 24px;
            margin-top: 5px;
            
          "
        >
          <div style="font-size: 12px; color: #03a5fc; font-weight: bold">
            Pre-Paid Gas Meter:<span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.gasMeter}</span
            >
          </div>

          <div style="font-size: 12px; color: #03a5fc; font-weight: bold">
            Reading:
            <span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.gasMeterReading}</span
            >
          </div>
          
        </div>
        
        <hr
          style="border: 1px solid #03a5fc; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 250px; height: 180px;display: block; text-align: center;object-fit: cover;
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  "
            src="${Paths.baseUrl + "/" + data!.gasMeterImg.toString()}"
            alt="s1"
          />
      </div>

      <div
        style="
          width: 560px;
          height: 260px;

          border: 4px solid rgb(207, 206, 206);
          border-radius: 14px;
        "
      >
        <div
          style="
            display: flex;
            justify-content: space-between;
            margin-left: 24px;
            margin-right: 24px;
            margin-top: 16px;
            
          "
        >
          <div style="font-size: 12px; color: #03a5fc; font-weight: bold">
            Pre-Paid Electric Meter:<span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.electricityMeter}</span
            >
          </div>

          <div style="font-size: 14px; color: #03a5fc; font-weight: bold">
            Reading:
            <span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.electricityMeterReading}</span
            >
            
          </div>
          
        </div>
        
        <hr
          style="border: 1px solid #03a5fc; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 250px; height: 180px;display: block; text-align: center;object-fit: cover;
  margin-left: auto;
  margin-right: auto;
  "
            src="${Paths.baseUrl + "/" + data!.electricityMeterImg.toString()}"
            alt="s1"
          />
      </div>
    </div>

    <div
      style="
        display: flex;
        margin-left: 48px;
        margin-top: 30px;
        margin-right: 48px;
        justify-items: center;
        justify-content: center;
        align-items: center;
        gap: 35px;
      "
    >
    <div
        style="
          width: 510px;
          height: 260px;
          border: 4px solid rgb(207, 206, 206);
          border-radius: 14px;
        "
      >
        <div
          style="
            display: flex;
            justify-content: space-between;
            margin-left: 24px;
            margin-right: 24px;
            margin-top: 16px;
            
          "
        >
          <div style="font-size: 12px; color: #03a5fc; font-weight: bold">
            Water Meter:<span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.waterMeter}</span
            >
          </div>

          <div style="font-size: 14px; color: #03a5fc; font-weight: bold">
            Reading:
             <span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.waterMeterReading}</span
            >
            
          </div>
          
        </div>
        
        <hr
          style="border: 1px solid #03a5fc; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 250px; height: 180px;display: block; text-align: center;object-fit: cover;
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  "
            src="${Paths.baseUrl + "/" + data!.waterMeterImg.toString()}"
            alt="s1"
          />
      </div>
      <div
        style="
           width: 560px;
          height: 260px;

          border: 4px solid rgb(207, 206, 206);
          border-radius: 14px;
        "
      >
        <div
          style="
            display: flex;
            justify-content: space-between;
            margin-left: 24px;
            margin-right: 24px;
            margin-top: 16px;
            
          "
        >
          <div style="font-size: 12px; color: #03a5fc; font-weight: bold">
            Heating System:<span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.heatingSystem}</span
            >
          </div>

          
          
        </div>
        
        <hr
          style="border: 1px solid #03a5fc; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 250px; height: 180px;display: block; text-align: center;object-fit: cover;
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  "
            src="${Paths.baseUrl + "/" + data!.heatingSystemImg.toString()}"
            alt="s1"
          />
      </div>
      
    </div>

     <div
      style="
        display: flex;
        margin-left: 48px;
        margin-top: 30px;
        margin-right: 48px;
        justify-items: center;
        justify-content: center;
        align-items: center;
        gap: 35px;
      "
    >
      <div
        style="
          width: 510px;
          height: 260px;
          border: 4px solid rgb(207, 206, 206);
          border-radius: 14px;
        "
      >
        <div
          style="
            display: flex;
            justify-content: space-between;
            margin-left: 24px;
            margin-right: 24px;
            margin-top: 16px;
            
          "
        >
          <div style="font-size: 12px; color: #03a5fc; font-weight: bold">
            Smoking Alarm:<span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.smokeAlarm}</span
            >
          </div>
          
          
        </div>
        
        <hr
          style="border: 1px solid #03a5fc; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 250px; height: 180px;display: block; text-align: center;object-fit: cover;
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  "
            src="${Paths.baseUrl + "/" + data!.smokeAlarmFrontImg.toString()}"
            alt="s1"
          />
      </div>
      <div
        style="
          width: 560px;
          height: 260px;

          border: 4px solid rgb(207, 206, 206);
          border-radius: 14px;
        "
      >
        <div
          style="
            display: flex;
            justify-content: space-between;
            margin-left: 24px;
            margin-right: 24px;
            margin-top: 16px;
            
          "
        >
          <div style="font-size: 12px; color: #03a5fc; font-weight: bold">
            CO Alarm:<span
              style="font-size: 12px; color: black; font-weight: bold"
              >${data?.coAlarm}</span
            >
          </div>

       
          
        </div>
        
        <hr
          style="border: 1px solid #03a5fc; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 250px; height: 180px;display: block; text-align: center;object-fit: cover;
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  "
            src="${Paths.baseUrl + "/" + data!.coAlarmFrontImg.toString()}"
            alt="s1"
          />
      </div>
    </div>
    <br>
    <br>
    <br>

    
   
   
    
  
    ${propertyList.map((e) => '''
      <div
      style="
        font-size: 24px;
        color: #03a5fc;
        height:1048px;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 5px;

      "
    >
    <br>
    <br>
    <br>
    
    <div style="margin-left: 40px; font-size: 18px;">
      ${e.name}
    </div>
    <div style="margin-left: 38px; margin-right: 38px; margin-top: 10px">
      <table id="customers">
        <tr >
          <th style="font-size: 12px;">Description</th>
          <th style="width:80%;text-align: center; font-size: 12px;">Details</th>
        </tr>
        <tr>
          <td style="font-size: 12px;">Floor</td>
          <td style="font-size: 10px;font-weight: 500;">${e.floor}</td>
        </tr>
        ${e.name == "Kitchen" ? '''<tr>
                            <td style="font-size: 12px;">Appliances</td>
                            <td style="font-size: 10px;font-weight: 500;">${e.appliances}</td>
                            </tr>''' : ''''''}
                             ${e.name == "Kitchen" ? '''<tr>
                            <td style="font-size: 12px;">Units</td>
                            <td style="font-size: 10px;font-weight: 500;">${e.units}</td>
                            </tr>''' : ''''''}
        <tr>
        
          <td style="font-size: 12px;">Walls</td>
          <td style="font-size: 10px;font-weight: 500;">${e.walls}</td>
        </tr>
        ${e.name != "Rear Garden" && e.name != "Front & Side Aspects" ? '''<tr>
          <td style="font-size: 12px;">Ceiling</td>
          <td style="font-size: 10px;font-weight: 500;">${e.ceiling != null ? e.ceiling : ""}</td>
        </tr>''' : ''''''}
        <tr>
          <td style="font-size: 12px;">Windows</td>
          <td style="font-size: 10px;font-weight: 500;">${e.windows}</td>
        </tr>
        <tr>
          <td style="font-size: 12px;">Doors</td>
          <td style="font-size: 10px;font-weight: 500;">${e.walls}</td>
        </tr>
        <tr>
          <td style="font-size: 12px;">Details</td>
          <td style="font-size: 10px;font-weight: 500;">${e.description != null ? e.description : ""}</td>
        </tr>
      </table>
    </div>
 <br>
    <div  class="image-container" >
   
             ${e.propertyImages?.map((b) => b.url!.contains("upload") ? '''
      <img  src="${Paths.baseUrl + "/" + b.url.toString()}" alt="" style="width: 150px; height: 150px;object-fit: cover;" />
      ''' : '''''').join('')}
    
    </div>
    
      </div>
  ''').join('')}
  <br>
    <br>
    <br>
    <br>
    <br>
 <br>
    <br>
    <div
      style="
        font-size: 14px;
        color: #03a5fc;
        margin-left: 48px;
         text-align: center;
        font-weight: bold;
        margin-top: 25px;
      "
    >
      Advice for Tenant:
    </div>

    <div
      style="
        font-size: 12px;
        color: black;
        margin-left: 48px;
        margin-right: 48px;
        font-weight: 500;
        margin-top: 10px;
      "
    >
      ${data?.advisedTenantTo}
    </div>
    <hr
      style="border: 2px solid black; margin-left: 48px; margin-right: 48px"
    />
    <div
      style="
        font-size: 14px;
        color: #03a5fc;
        margin-left: 48px;
         text-align: center;
        font-weight: bold;
        margin-top: 25px;
      "
    >
      Advice for Landlord:
    </div>
     <div
      style="
        font-size: 12px;
        color: black;
        margin-left: 48px;
        margin-right: 48px;
        font-weight: 500;
        margin-top: 10px;
      "
    >
      ${data?.askedLandlordTo}
    </div>
    <hr
      style="
        border: 2px solid black;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 12px;
      "
    />

    <div
      style="
        font-size: 14px;
        color: #03a5fc;
        text-align: center;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 25px;
      "
    >
      Declaration
    </div>

    <div
      style="
        font-size: 12px;
        color: black;
        text-align: center;
        margin-left: 48px;
        margin-right: 48px;
        font-weight: 500;
        margin-top: 5px;
      "
    >
      This inventory provides a record of the contents of the property and the
      property’s internal condition. The person preparing the inventory is not
      an expert in fabrics, wood, materials, antiques etc nor a qualified
      surveyor. The inventory should not be used as an accurate description of
      each piece of furniture and equipment. Any areas of dilapidation or defect
      at the commencement of the tenancy need to be reported to the
      landlord/agency within 7 days of the commencement of tenancy. All items
      and areas listed in the property are in good, clean, serviceable condition
      unless otherwise stated.
    </div>
<br>
<br>
    <div
      style="
        display: flex;
        margin-left: 48px;
        margin-top: 1px;
        margin-right: 48px;
        justify-items: center;
        justify-content: center;
        align-items: center;
        gap: 45px;
      "
    >
      <div
        style="
          width: 300px;
          height: 300px;

          border: 6px solid rgb(42, 119, 219);
          border-radius: 14px;
        "
      >
        <div
          style="
            font-size: 14px;
            color: black;
            font-weight: bold;
            margin-top: 5px;
            text-align: center;
          "
        >
          Tenant’s Signature
        </div>

        <div
          style="
            
            justify-content: center;
            align-items: center;
            margin-top: 20px;
          "
        >
          <img src="${Paths.baseUrl + "/" + decodedString}" alt="Base64 Image" height="200px" width="200px">
        </div>
      </div>
      <div
        style="
          width: 300px;
          height: 300px;
          border: 6px solid rgb(42, 119, 219);
          border-radius: 14px;
        "
      >
        <div
          style="
            font-size: 14px;
            color: black;
            font-weight: bold;
            margin-top: 5px;
            text-align: center;
          "
        >
          Inspector’s Signature
        </div>

        <div
          style="
            
            justify-content: center;
            align-items: center;
            margin-top: 20px;
          "
        >
          <img
            style="border-radius: 12px;"
            src="${Paths.baseUrl + "/" + decodedString1}"
            alt="s1"
            height="200px" width="200px"
          />
        </div>
      </div>
    </div>
  </body>
</html>

""";
                        Directory tempDir = await getTemporaryDirectory();
                        final path = '${tempDir.path}';

                        final generatedPdfFile =
                            await FlutterHtmlToPdf.convertFromHtmlContent(
                                htmlContent, path, "report.pdf");
                        controller.isLoading.value = false;
                        Share.shareFiles([generatedPdfFile.path]);
                      },
                      child: Text("Export Pdf"),
                      minWidth: Get.width,
                      height: 50,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 100,
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
