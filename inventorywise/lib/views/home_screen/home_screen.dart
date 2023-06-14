import 'package:InventoryWise/views/forgot_password/forgot_password_screen.dart';
import 'package:InventoryWise/views/home_screen/add_data/add_data.dart';
import 'package:InventoryWise/views/home_screen/home_controller.dart';
import 'package:InventoryWise/views/home_screen/show_data/show_data.dart';
import 'package:InventoryWise/views/register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/global.dart';

class Home_Screen extends StatelessWidget {
  Home_Screen({id}) : super();
  String? id;
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false, // fluter 2.x
        floatingActionButton: Container(
          height: 100.0,
          width: 180.0,
          child: FittedBox(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                Get.to(() => AddDataScreen());
              },
              color: Colors.blue,
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "Add Property",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("Dashboard"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: Get.width,
                padding: EdgeInsets.zero,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    'abc',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ua@gmail.com',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/splash/splash.png"),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                leading: Icon(Icons.shield),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('Reset Password'),
                onTap: () {
                  Get.to(() => Forgot_Screen());
                },
              ),
              Spacer(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
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
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Search"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: Get.height * 0.47,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: controller.data.value.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: Get.width - 5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => Show_Data_Screen(
                                  data: controller.data[index],
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        controller.data[index].mainImg
                                            .toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.data[index].inspectorName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Inspection Date:" +
                                          DateTime.parse(controller
                                                  .data[index].inspectionDate
                                                  .toString())
                                              .day
                                              .toString() +
                                          "-" +
                                          DateTime.parse(controller
                                                  .data[index].inspectionDate
                                                  .toString())
                                              .month
                                              .toString() +
                                          "-" +
                                          DateTime.parse(controller
                                                  .data[index].inspectionDate
                                                  .toString())
                                              .year
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 180,
                                      child: Text(
                                        overflow: TextOverflow.clip,
                                        softWrap: false,
                                        "Inspector Name:" +
                                            controller.data[index].inspectorName
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
