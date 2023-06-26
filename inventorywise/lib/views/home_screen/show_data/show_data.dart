import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:InventoryWise/views/home_screen/show_data/showdata_controller.dart';
import 'package:InventoryWise/views/home_screen/update_data/update_data.dart';
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

import '../../../models/homedata/Home_Data.dart';
import '../../../utils/global.dart';

class Show_Data_Screen extends StatelessWidget {
  Show_Data_Screen({this.data, this.email});
  Rows? data;
  String? email;
  final controller = Get.put(ShowDataController());
  @override
  Widget build(BuildContext context) {
    final Uint8List bytes = Uint8List.fromList(data!.signatureTenant!.data!);
    String base64Image = base64Encode(bytes);
    String decodedString = utf8.decode(base64Decode(base64Image));
    final Uint8List bytes1 =
        Uint8List.fromList(data!.signatureInspector!.data!);
    String base64Image1 = base64Encode(bytes1);
    String decodedString1 = utf8.decode(base64Decode(base64Image1));

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false, // fluter 2.x
      appBar: AppBar(
        title: Text("Property Details"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Inventory Report",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  data!.tenantName.toString(),
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
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.network(
                    Paths.baseUrl + "/" + data!.mainImg.toString(),
                    fit: BoxFit.fill,
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
                                  id: data?.id.toString(),data: data,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inspection Date:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
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
                    SizedBox()
                  ],
                ),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ECP Date:           ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    Text(
                      DateTime.parse(data!.ecpExpDate.toString())
                              .day
                              .toString() +
                          "-" +
                          DateTime.parse(data!.ecpExpDate.toString())
                              .month
                              .toString() +
                          "-" +
                          DateTime.parse(data!.ecpExpDate.toString())
                              .year
                              .toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox()
                  ],
                ),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ECIR Date:         ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    Text(
                      DateTime.parse(data!.ecirExpDate.toString())
                              .day
                              .toString() +
                          "-" +
                          DateTime.parse(data!.ecirExpDate.toString())
                              .month
                              .toString() +
                          "-" +
                          DateTime.parse(data!.ecirExpDate.toString())
                              .year
                              .toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox()
                  ],
                ),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Gas Saftey Certificate Exipiry Date:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )),
                    Text(
                      DateTime.parse(
                                  data!.gasSafetyCertificateExpDate.toString())
                              .day
                              .toString() +
                          "-" +
                          DateTime.parse(
                                  data!.gasSafetyCertificateExpDate.toString())
                              .month
                              .toString() +
                          "-" +
                          DateTime.parse(
                                  data!.gasSafetyCertificateExpDate.toString())
                              .year
                              .toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox()
                  ],
                ),
                Divider(
                  thickness: 1.5,
                ),
                Container(
                  height: 180,
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
                            Text(
                              "Pre-Paid Gas Meter:" + data!.gasMeter.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Reading:" + data!.gasMeterReading.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.5,
                        ),
                        Image.network(
                          Paths.baseUrl + "/" + data!.gasMeterImg.toString(),
                          height: 120,
                          width: Get.width,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
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
                            Text(
                              "Pre-Paid Electricity Meter:" +
                                  data!.electricityMeter.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Reading:" +
                                  data!.electricityMeterReading.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
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
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
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
                            Text(
                              "Water Meter:" + data!.waterMeter.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Reading:" + data!.waterMeterReading.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.5,
                        ),
                        Image.network(
                          Paths.baseUrl + "/" + data!.waterMeterImg.toString(),
                          height: 120,
                          width: Get.width,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
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
                            Text(
                              "Smoke Alarm:" + data!.smokeAlarm.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Reading:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
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
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
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
                            Text(
                              "CO Alarm:" + data!.coAlarm.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Reading:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
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
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
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
                            Text(
                              "Heating System Working:" +
                                  data!.heatingSystem.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Reading:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
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
                          fit: BoxFit.fill,
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
                    itemBuilder: (BuildContext context, int index) => Container(
                      margin: EdgeInsets.only(left: 10),
                      child: MaterialButton(
                        height: 45,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.blue,
                        onPressed: () {
                          controller.value.value = index;
                        },
                        child:
                            Text(data!.propertyDetails![index].name.toString()),
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
                              data!.propertyDetails![controller.value.toInt()]
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
                        Text(
                          "Walls: " +
                              data!.propertyDetails![controller.value.toInt()]
                                  .walls
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Windows: " +
                              data!.propertyDetails![controller.value.toInt()]
                                  .walls
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Other Details: " +
                              data!.propertyDetails![controller.value.toInt()]
                                  .walls
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Walls: " +
                              data!.propertyDetails![controller.value.toInt()]
                                  .walls
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18),
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
                            spacing: 1,
                            children: [
                              for (int i = 0;
                                  i <
                                      data!
                                          .propertyDetails![
                                              controller.value.toInt()]
                                          .propertyImages!
                                          .length;
                                  i++)
                                if (data!
                                    .propertyDetails![controller.value.toInt()]
                                    .propertyImages![i]
                                    .url!
                                    .contains("upload")) ...[
                                  SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(Paths.baseUrl +
                                          "/" +
                                          data!
                                              .propertyDetails![
                                                  controller.value.toInt()]
                                              .propertyImages![i]
                                              .url
                                              .toString())),
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Advice For Landlord:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1.5,
                ),
                Text(
                  "Summary:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
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
                            "Tenant:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(data!.tenantName.toString()),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "Inspector:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(data!.inspectorName.toString()),
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
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var lo = prefs.getString("logo").toString();
                      // Directory tempDir = await getTemporaryDirectory();
                      // final path = '${tempDir.path}/report.pdf';
                      //
                      // await Dio().download(
                      //     "https://api.propelinspections.com/inventory/uploads/umair1686570916.pdf",
                      //     path);
                      //
                      // Share.shareFiles([path]);
                      // Share.share("https://api.propelinspections.com/inventory/uploads/umair1686570916.pdf");
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
      border: 1px solid black;
    }
.image-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px; /* Adjust the gap as per your requirements */
}

.image-container img {
  width: 100%;
  height: auto;
}

    table {
      border-collapse: collapse;
      width: 30%;
    }

    #customers {
      font-family: Arial, Helvetica, sans-serif;
      border-collapse: collapse;
      width: 100%;
    }

    #customers td,
    #customers th {
      border: 1px solid #ddd;
      padding: 8px;
    }

    #customers tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    #customers tr:hover {
      background-color: #ddd;
    }

    #customers th {
      padding-top: 12px;
      padding-bottom: 12px;
      text-align: left;
      background-color: blue;
      color: white;
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
              style="width: 230px; height: 100px"
              src="${Paths.baseUrl + "/" + lo}"
              alt="Logo"
            />
          </div>
          <div style="">
            <div style="display: flex; gap: 6px">
              <div style="color: blue; font-size: 18px; font-weight: bold">
                Company:
              </div>
              <div style="color: black; font-size: 18px">"Promptmove Limited"</div>
            </div>

            <div style="display: flex; gap: 6px">
              <div style="color: blue; font-size: 18px; font-weight: bold">
                Address:
              </div>
              <div style="color: black; font-size: 18px">${data?.propertyAddress}</div>
            </div>

            <div style="display: flex; gap: 6px">
              <div style="color: blue; font-size: 18px; font-weight: bold">
                Phone:
              </div>
              <div style="color: black; font-size: 18px">01582 611040</div>
            </div>
            <div style="display: flex; gap: 6px">
              <div style="color: blue; font-size: 18px; font-weight: bold">
                Email:
              </div>
              <div style="color: black; font-size: 18px">${email}</div>
            </div>
          </div>
        </div>
      </div>
    </header>
    <div
      style="
        font-size: 32px;
        text-align: center;
        background-color: blue;
        color: white;
        border-radius: 14px;
        border-color: black;
        padding-top: 20px;
        padding-bottom: 20px;
        border: 10px;
        margin-left: 100px;
        margin-right: 100px;
        margin-top:20px;
        border-style: solid;
        border-width: medium;
        border-color: black;
      "
    >
      ${data?.types}
    </div>
    <div
      style="
        font-size: 32px;
        color: black;
        text-align: center;
        font-weight: bold;
      "
    >
      ${data?.inspectorName}
    </div>
    <div style="display: flex; justify-content: center; align-items: center">
      <img style="border-radius: 12px; border-radius: 12px; width: 400px; height: 250px" src="${Paths.baseUrl + '/' + data!.mainImg.toString()}" alt="s1"/>
    </div>
    <div
      style="
        display: flex;
        align-items: center;
        justify-content: center;
        margin-top: 30px;
      "
    >
      <table style="width:100%">
        <tr>
          <td
            style="
              font-size: 24px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            Inspected By
          </td>
          <td
            style="
              font-size: 24px;
              padding-top: 8px;
              padding-bottom: 8px;
              font-weight: 300;
            "
          >
            ${data?.inspectorName}
          </td>
        </tr>
        <tr>
          <td
            style="
              font-size: 24px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            Tenants name
          </td>
          <td style="font-size: 24px; padding-top: 8px; padding-bottom: 8px">
            ${data?.tenantName}
          </td>
        </tr>
        <tr>
          <td
            style="
              font-size: 24px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            Date of Inspection
          </td>
          <td style="font-size: 24px; padding-top: 8px; padding-bottom: 8px">
            ${data?.inspectionDate}
          </td>
        </tr>
        <tr>
          <td
            style="
              font-size: 24px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            EPC Expiry Date
          </td>
          <td style="font-size: 24px; padding-top: 8px; padding-bottom: 8px">
            ${data?.ecpExpDate}
          </td>
        </tr>
        <tr>
          <td
            style="
              font-size: 24px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            Gas Safety Certificate Expiry Date
          </td>
          <td style="font-size: 24px; padding-top: 8px; padding-bottom: 8px">
            ${data?.gasSafetyCertificateExpDate}
          </td>
        </tr>
        <tr>
          <td
            style="
              font-size: 24px;
              font-weight: bold;
              padding-top: 8px;
              padding-bottom: 8px;
            "
          >
            EICR Expiry Date
          </td>
          <td style="font-size: 24px; padding-top: 8px; padding-bottom: 8px">
            ${data?.ecirExpDate}
          </td>
        </tr>
      </table>
    </div>
    <div
      style="
        font-size: 32px;
        color: blue;
        margin-left: 36px;
        font-weight: bold;
        margin-top: 6px;
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
        margin-left: 36px;
        margin-right: 36px;
      "
    ></div>
    <div
      style="
        font-size: 24px;
        color: blue;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 6px;
      "
    >
      Important Information
    </div>
    <div
      style="
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 26px;
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
        font-size: 20px;
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
        font-size: 20px;
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
    <div
      style="
        font-size: 28px;
        color: blue;
        margin-left: 36px;
        font-weight: bold;
        margin-top: 6px;
      "
    >
      Metres and Alarms
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
          width: 450px;
          height: 305px;

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
          <div style="font-size: 24px; color: blue; font-weight: bold">
            Pre-Paid Gas Meter:<span
              style="font-size: 24px; color: black; font-weight: bold"
              >${data?.gasMeter}</span
            >
          </div>

          <div style="font-size: 24px; color: blue; font-weight: bold">
            Reading:${data?.gasMeterReading}
          </div>
          
        </div>
        
        <hr
          style="border: 1px solid blue; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 320px; height: 200px;display: block;
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
          width: 450px;
          height: 305px;

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
          <div style="font-size: 24px; color: blue; font-weight: bold">
            Pre-Paid Electric Meter:<span
              style="font-size: 24px; color: black; font-weight: bold"
              >${data?.electricityMeter}</span
            >
          </div>

          <div style="font-size: 24px; color: blue; font-weight: bold">
            Reading:${data?.electricityMeterReading}
          </div>
          
        </div>
        
        <hr
          style="border: 1px solid blue; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 320px; height: 200px;display: block;
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
          width: 450px;
          height: 305px;

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
          <div style="font-size: 24px; color: blue; font-weight: bold">
            Heating System:<span
              style="font-size: 24px; color: black; font-weight: bold"
              >${data?.heatingSystem}</span
            >
          </div>
<div style="font-size: 24px; color: white; font-weight: bold">
            Reading:${data?.waterMeterReading}
          </div>
          
          
        </div>
        
        <hr
          style="border: 1px solid blue; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 320px; height: 200px;display: block;
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  "
            src="${Paths.baseUrl + "/" + data!.heatingSystemImg.toString()}"
            alt="s1"
          />
      </div>
      <div
        style="
          width: 450px;
          height: 305px;

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
          <div style="font-size: 24px; color: blue; font-weight: bold">
            Water Meter:<span
              style="font-size: 24px; color: black; font-weight: bold"
              >${data?.waterMeter}</span
            >
          </div>

          <div style="font-size: 24px; color: blue; font-weight: bold">
            Reading:${data?.waterMeterReading}
          </div>
          
        </div>
        
        <hr
          style="border: 1px solid blue; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 320px; height: 200px;display: block;
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  "
            src="${Paths.baseUrl + "/" + data!.waterMeterImg.toString()}"
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
          width: 450px;
          height: 305px;

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
          <div style="font-size: 24px; color: blue; font-weight: bold">
            Smoking Alarm:<span
              style="font-size: 24px; color: black; font-weight: bold"
              >${data?.smokeAlarm}</span
            >
          </div>
          
          
        </div>
        
        <hr
          style="border: 1px solid blue; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 320px; height: 230px;display: block;
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
          width: 450px;
          height: 305px;

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
          <div style="font-size: 24px; color: blue; font-weight: bold">
            CO Alarm:<span
              style="font-size: 24px; color: black; font-weight: bold"
              >${data?.coAlarm}</span
            >
          </div>

       
          
        </div>
        
        <hr
          style="border: 1px solid blue; margin-left: 24px; margin-right: 24px"
        />
        
        <img
            style="border-radius: 12px; width: 320px; height: 230px;display: block;
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
   
   
    
  
    ${data?.propertyDetails?.map((e) => '''
      <div
      style="
        font-size: 24px;
        color: blue;
        height:1190px;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 45px;
      "
    >
    <br>
    <br>
    <br>
    
    <div>
      ${e.name}
    </div>
    <div style="margin-left: 48px; margin-right: 48px; margin-top: 20px">
      <table id="customers">
        <tr>
          <th>Description</th>
          <th>Details</th>
        </tr>
        <tr>
          <td>Floor</td>
          <td>${e.floor}</td>
        </tr>
        <tr>
          <td>Walls</td>
          <td>${e.walls}</td>
        </tr>
        <tr>
          <td>Ceiling</td>
          <td>${e.ceiling}</td>
        </tr>
        <tr>
          <td>Windows</td>
          <td>${e.windows}</td>
        </tr>
        <tr>
          <td>Doors</td>
          <td>${e.walls}</td>
        </tr>
        <tr>
          <td>Description</td>
          <td>${e.description}</td>
        </tr>
      </table>
    </div>
 <br><br>
    <div  class="image-container" >
   
             ${e.propertyImages?.map((b) => b.url!.contains("upload") ? '''
      <img  src="${Paths.baseUrl + "/" + b.url.toString()}" alt="" style="width: 300px; height: 250px;" />
      ''' : '''''').join('')}
    
    </div>
    <br>
     <br>
      <br>
      </div>
  ''').join('')}
  <br>
    <br><br>
    <br>
    <div
      style="
        font-size: 28px;
        color: blue;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 25px;
      "
    >
      Advice for Tenant:
    </div>

    <div
      style="
        font-size: 28px;
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
        font-size: 28px;
        color: blue;
        margin-left: 48px;
        font-weight: bold;
        margin-top: 25px;
      "
    >
      Advice for Landlord:
    </div>
    <hr
      style="
        border: 2px solid black;
        margin-left: 48px;
        margin-right: 48px;
        margin-top: 12px;
      "
    />
${data?.askedLandlordTo}
    <div
      style="
        font-size: 24px;
        color: blue;
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
        font-size: 24px;
        color: black;
        text-align: center;
        margin-left: 48px;
        margin-right: 48px;
        font-weight: 500;
        margin-top: 25px;
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

    <div
      style="
        display: flex;
        margin-left: 48px;
        margin-top: 30px;
        margin-right: 48px;
        justify-items: center;
        justify-content: center;
        align-items: center;
        gap: 45px;
      "
    >
      <div
        style="
          width: 600px;
          height: 340px;

          border: 6px solid rgb(42, 119, 219);
          border-radius: 14px;
        "
      >
        <div
          style="
            font-size: 32px;
            color: black;
            font-weight: bold;
            margin-top: 20px;
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
          <img src="${Paths.baseUrl + "/" + decodedString}" alt="Base64 Image">
        </div>
      </div>
      <div
        style="
          width: 600px;
          height: 340px;
          border: 6px solid rgb(42, 119, 219);
          border-radius: 14px;
        "
      >
        <div
          style="
            font-size: 32px;
            color: black;
            font-weight: bold;
            margin-top: 20px;
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
                        htmlContent,
                        path,
                        "report.pdf",
                      );
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
    );
  }
}
