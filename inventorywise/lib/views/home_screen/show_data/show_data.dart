import 'dart:io';

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

import '../../../models/homedata/Home_Data.dart';
import '../../../utils/global.dart';

class Show_Data_Screen extends StatelessWidget {
  Show_Data_Screen({this.data});
  Rows? data;
  final controller = Get.put(ShowDataController());
  @override
  Widget build(BuildContext context) {
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
                                  id: data?.id.toString(),
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
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: data!
                                          .propertyDetails![
                                              controller.value.toInt()]
                                          .propertyImages![i]
                                          .url!
                                          .contains("upload")
                                      ? Image.network(Paths.baseUrl +
                                          "/" +
                                          data!
                                              .propertyDetails![
                                                  controller.value.toInt()]
                                              .propertyImages![i]
                                              .url
                                              .toString())
                                      : Image.asset("assets/logo/logo.jpg"),
                                ),
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
                      `<!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8">
        <title>Report Title</title>
      </head>
      <style>
        body {
          width: 90%;
          display: block;
          margin: auto;
          background-color: #fff;
          border: 2px solid #0090ff;
          padding: 20px;
          border-radius: 10px;
        }

        .header-container {
          display: flex;
          justify-content: space-between;
          align-items: center;
          flex-wrap: wrap;
          /* padding: 40px auto; */
          background-color: #0090ff1a;
          padding: 20px;
          border-radius: 10px;
          /* border: 2px solid #0090ff; */
        }

        .logo img {
          max-width: 200px;
          height: auto;
          margin: 0 20px 0 0;
        }

        .user-info {
          margin: 0 0 20px 0;
          margin-top: 20px;
        }

        @media (max-width: 600px) {
          .header-container {
            flex-direction: column;
            align-items: center;
          }

          .logo {
            margin: 10px 0;
          }

          .user-info {
            margin: 0;
            text-align: center;
          }
        }

        .top-address {
          font-weight: 600;
          text-align: center;
          padding: 10px 0px;
          background-color: #0090ff;
          font-size: 20px;
          color: #fff;
          border-radius: 10px 10px 0px 0px;
          margin-bottom: 0px;
        }

        .property-img {
          display: block;
          margin: auto;
          width: 100%;
          height: 200px;
          border-radius: 0px 0px 10px 10px;
        }



        table {
          border-collapse: collapse;
          width: 98.5%;
          margin: 20px 10px;
        }

        th
        td {
          padding: 12px;
          text-align: left;
        }

        thead {
          background-color: #333;
          color: #fff;
        }

        tbody tr:nth-child(even) {
          background-color: #f1f1f1;
        }

        tbody tr:hover {
          background-color: #ddd;
        }

        td {
          border: 1px solid #ddd;
        }

        th {
          border: 1px solid #333;
        }

        .parent {
          display: flex;

          /* margin: 20px 0; */
        }

        .card {
          width: 33%;
          border: 2px solid #eee;
          margin: 10px;
          border-radius: 10px;
          padding: 20px
        }

        .card1 {
          width: 50%;
          border: 2px solid #eee;
          margin: 10px;
          border-radius: 10px;
          padding: 20px
        }

        .card2 {
          /* width: 50%; */
          border: 2px solid #eee;
          margin: 10px;
          border-radius: 10px;
          padding: 20px
        }

        .card-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          flex-wrap: wrap;
          padding-bottom: 10px;
          border-bottom: 1px solid #0090ff;
        }

        .gas {
          color: #0090ff;
          font-weight: 600;
        }

        .gas-img img {
          margin-top: 10px;
          border-radius: 10px;
        }

        .gas-img2 {
          display: flex;
        }

        .gas-img2 img {
          margin: 10px;
          border-radius: 10px;
        }
      .body{
        display: flex;
        justify-content: flex-end;
      }
        .body .right {
          padding: 10px;
          margin: 10px;
        }


        .blue {
          color: #0090ff;
          font-weight: 600;
          font-size: 18px;
          padding-right: 10px;
        }
        .blue2 {
          color: #0090ff;
          font-weight: 600;
          font-size: 22px;
          margin-bottom: 0px;
        }

        .h1 {
          font-weight: bold;
          font-size: 1.2em;
          background-color: white;
          color: #0090ff;
        }

        .signatre {
          width: 100px;
          height: auto;
          /* align-self: flex-end */
        }
        .blue3{
          color: #0090ff;
          /* width: 100%; */
        }
      </style>

      <body>
        <header>
          <div class="header-container">
            <div class="logo">
            <img
                src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png"
                alt="Logo"> </div>

          </div>
        </header>
        <section>
          <p class="top-address">${data?.propertyAddress}</p>
            <img class="property-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png"
            alt="property image" />
        </section>
        <section class="top-margin">
          <div>
            <table>
              <tr>
                <td class="blue3">ECIR Expiry Date:</td>
                <td>${data?.ecirExpDate}</td>
                <td class="blue3">Gas Safety Certificate Expiry Date:</td>
                <td>${data?.gasSafetyCertificateExpDate}</td>
                <td class="blue3">Inspection Date:</td>
                <td>${data?.inspectionDate}</td>

              </tr>
              <tr>
                <td class="blue3">EPC Expiry Date:</td>
                <td>${data?.ecpExpDate}</td>
                <td class="blue3">Tenant Name:</td>
                <td>${data?.tenantName}</td>
                <td class="blue3">Inspector Name:</td>
                <td>${data?.inspectorName}</td>
              </tr>
              <tr>
                <td class="blue3">Advised Tenant To:</td>
                <td>${data?.advisedTenantTo}</td>
                <td class="blue3">Contractor Instructed:</td>
                <td>${data?.contractorInstructed}</td>
                <td class="blue3">Asked Landlord To:</td>
                <td>${data?.askedLandlordTo}</td>

              </tr>
            </table>
          </div>
        </section>
        <section class="top-margin" id="cards">
          <div class="parent">
            <div class="card">
              <div class="card-header">
                <div class="col-1"> <span class="gas">Gas Meter:</span> <span class="gas">Yes</span> </div>
                <div class="col-1"> <span class="gas">Reading:</span> <span class="gas">${data?.gasMeterReading}</span> </div>
              </div>
              <div class="gas-img">
              <img
              src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" width="100%" height="auto">
                </div>
            </div>
            <div class="card">
              <div class="card-header">
                <div class="col-1"> <span class="gas">Electricity Meter:</span> <span class="gas">${data?.electricityMeter}</span> </div>
                <div class="col-1"> <span class="gas">Reading:</span> <span class="gas">${data?.electricityMeterReading}</span> </div>
              </div>
              <div class="gas-img"> <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" width="100%" height="auto"> </div>
            </div>
            <div class="card">
              <div class="card-header">
                <div class="col-1"> <span class="gas">Water Meter:</span> <span class="gas">${data?.waterMeter}</span> </div>
                <div class="col-1"> <span class="gas">Reading:</span> <span class="gas">${data?.waterMeterReading}</span> </div>
              </div>
              <div class="gas-img"> <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" width="100%" height="auto"> </div>
            </div>
            <div class="card">
              <div class="card-header">
                <div class="col-1"> <span class="gas">Heating System:</span> <span class="gas"></span> </div>
                <div class="col-1"> <span class="gas">Reading:</span> <span class="gas">Yes</span> </div>
              </div>
              <div class="gas-img">
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" width="100%" height="auto"> </div>
            </div>
          </div>
        </section>
        <section class="top-margin">
          <div class="parent">
            <div class="card1">
              <div class="card-header">
                <div class="col-1"> <span class="gas">Smoke Alarm:</span> <span class="gas">${data?.smokeAlarm}</span> </div>
              </div>
              <div class="gas-img2">
                  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" width="48%" height="auto">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png"
                  width="48%" height="auto" /> </div>
            </div>
            <div class="card1">
              <div class="card-header">
                <div class="col-1"> <span class="gas">CO Alarm:</span> <span class="gas">${data?.coAlarm}</span> </div>
              </div>
              <div class="gas-img2">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" width="48%" height="auto">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png"
                  width="48%" height="auto" /> </div>
            </div>
          </div>

        </section>
       <section class="top-margin">
      ${data?.propertyDetails?.map((item) => '''
        <div class="card2">
          <div class="card-header">
            <div class="col-1">
              <span class="blue2">${item.name}</span>
              <p class="room-para">${item.description}</p>
            </div>
          </div>
          <div class="gas-img2"></div>
        </div>
      ''').join('')}
    </section>

        </section>

        <section>
          <div class="body">
            <div class="right" style="background-color: #fff">
              <h1 class="h1">Tenant Name</h1>
              <h4>${data?.tenantName}</h4>
              <img class="signatre" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" alt="" />
            </div>
            <div class="right" style="background-color: #fff"></div>
            <div class="right" style="background-color: #fff">
              <h1 class="h1">Inspector Name</h1>
              <h4>${data?.inspectorName}</h4>
              <img class="signatre" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/391px-Apple_logo_black.svg.png" alt="" />
            </div>
          </div>
        </section>
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
