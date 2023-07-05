import 'dart:io';

import 'package:InventoryWise/models/addproperty/add_proprert_model.dart';
import 'package:InventoryWise/views/home_screen/add_data/add_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/global.dart';

class CustomProperty extends StatefulWidget {
  CustomPropertyState createState() => CustomPropertyState();
  CustomProperty(
      {this.data,
      this.name,
      required this.index,
      required this.images,
      this.units,
      this.floor,
      this.appliences,
      this.windows,
      this.doors,
      this.celling,
      this.walls});
  List<PropertyDetails>? data;
  String? name;
  String? units;
  String? celling;
  String? floor;
  String? appliences;
  String? windows;
  String? doors;
  String? walls;

  int index;
  List<List<String>> images;
}

class CustomPropertyState extends State<CustomProperty> {
  late String url1;
  late String url2;
  late String url3;
  late String url4;
  late String url5;
  late String url6;
  late String url7;
  late String url8;
  late String url9;
  List<String> imagess = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  File imaage = File("");
  File image1 = File("");
  File image2 = File("");
  File image3 = File("");
  File image4 = File("");
  File image5 = File("");
  File image6 = File("");
  File image7 = File("");
  File image8 = File("");
  TextEditingController et1 = TextEditingController();
  TextEditingController et2 = TextEditingController();
  TextEditingController et3 = TextEditingController();
  TextEditingController et4 = TextEditingController();
  TextEditingController et5 = TextEditingController();
  TextEditingController et6 = TextEditingController();
  TextEditingController et7 = TextEditingController();
  TextEditingController et8 = TextEditingController();
  PropertyDetails? pd;

  final controller = Get.find<AddDataController>();
  int i = 0;
  void initState() {
    super.initState();
    pd = PropertyDetails();
    widget.data?.add(pd!);
    widget.data?[widget.index] = pd!;
    widget.data?[widget.index].name = widget.name;
    widget.data?[widget.index].images = imagess;
    widget.data = widget.data?.toSet().toList();
    print(widget.data?[widget.index].name);
    et2.text = "Fair";
    et3.text = "Fair";
    et4.text = "Fair";
    et6.text = "Fair";
    et7.text = "Fair";
    et8.text = "Fair";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    widget.walls != null
        ? et2.text = widget.walls.toString()
        : et2.text = "Fair";
    widget.windows != null
        ? et3.text = widget.windows.toString()
        : et3.text = "Fair";
    widget.floor != null
        ? et8.text = widget.floor.toString()
        : et8.text = "Fair";
    widget.doors != null
        ? et4.text = widget.doors.toString()
        : et4.text = "Fair";
    widget.units != null
        ? et6.text = widget.units.toString()
        : et6.text = "Fair";
    widget.appliences != null
        ? et7.text = widget.appliences.toString()
        : et7.text = "Fair";

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 15),
      width: Get.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  controller.count.value = 1;
                  controller.items.remove(widget.index);
                  if (widget.index >= 7) {
                    controller.list.value--;
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Text(
            widget.name.toString(),
            style:
                TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: et1,
            onTapOutside: (a) {
              if (et1.text.isNotEmpty) {
                widget.data?[widget.index].name = et1.text;
              }
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: widget.name),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                TextField(
                  controller: et2,
                  onTapOutside: (a) {
                    if (et2.text.isNotEmpty) {
                      widget.data?[widget.index].walls = et2.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Walls:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                if (widget.name == "Kitchen") ...[
                  TextField(
                    controller: et6,
                    onTapOutside: (a) {
                      if (et6.text.isNotEmpty) {
                        widget.data?[widget.index].units = et6.text;
                      }
                    },
                    decoration: InputDecoration(
                      icon: Text("Units:"),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  TextField(
                    controller: et7,
                    onTapOutside: (a) {
                      if (et7.text.isNotEmpty) {
                        widget.data?[widget.index].appliances = et7.text;
                      }
                    },
                    decoration: InputDecoration(
                      icon: Text("Appliances:"),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                ],
                if (widget.name != "Front & Side Aspects" &&
                    widget.name != "Rear Garden") ...[
                  TextField(
                    controller: et3,
                    onTapOutside: (a) {
                      if (et3.text.isNotEmpty) {
                        widget.data?[widget.index].windows = et3.text;
                      }
                    },
                    decoration: InputDecoration(
                      icon: Text("Ceilings:"),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                ],
                TextField(
                  controller: et3,
                  onTapOutside: (a) {
                    if (et3.text.isNotEmpty) {
                      widget.data?[widget.index].windows = et3.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Windows:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  controller: et8,
                  onTapOutside: (a) {
                    if (et8.text.isNotEmpty) {
                      widget.data?[widget.index].floor = et8.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Floors:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  controller: et4,
                  onTapOutside: (a) {
                    if (et4.text.isNotEmpty) {
                      widget.data?[widget.index].doors = et4.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Doors:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Other Details",
            style:
                TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: et5,
            onTapOutside: (a) {
              if (et5.text.isNotEmpty) {
                widget.data?[widget.index].description = et5.text;
              }
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Descriptions"),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Upload Images"),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: imaage.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(imaage.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            imaage = File("");
                                          });
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
                                  imaage = await controller.pickImages();
                                  setState(() {});
                                  url1 = await controller.upload(imaage);
                                  imagess[0] = url1;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[0] = url1;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  imaage = await controller.pickImageGallerys();
                                  setState(() {});
                                  if (imaage != null) {
                                    url1 = await controller.upload(imaage);
                                    imagess[0] = url1;
                                    imagess = imagess.toSet().toList();
                                    // widget.data?[widget.index].images = imagess;
                                    widget.data?[widget.index].images?[0] =
                                        url1;
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image1.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image1.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            image1 = File("");
                                          });
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
                                  image1 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url2 = await controller.upload(image1);
                                  imagess[1] = url2;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[1] = url2;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image1 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url2 = await controller.upload(image1);
                                  imagess[1] = url2;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[1] = url2;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image2.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image2.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            image2 = File("");
                                          });
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
                                  image2 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url3 = await controller.upload(image2);
                                  imagess[2] = url3;
                                  print(imagess[2]);
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[2] = url3;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image2 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url3 = await controller.upload(image2);
                                  imagess[2] = url3;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[2] = url3;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image3.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image3.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image3 = File("");
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
                                  image3 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url4 = await controller.upload(image3);
                                  imagess[3] = url4;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[3] = url4;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image3 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url4 = await controller.upload(image3);
                                  imagess[3] = url4;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[3] = url4;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image4.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image4.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image4 = File("");
                                          setState(() {});
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
                                  image4 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url5 = await controller.upload(image4);
                                  imagess[4] = url5;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[4] = url5;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image4 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url5 = await controller.upload(image4);
                                  imagess[4] = url5;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[4] = url5;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image5.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image5.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image5 = File("");
                                          setState(() {});
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
                                  image5 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url6 = await controller.upload(image5);
                                  imagess[5] = url6;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[5] = url6;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image5 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url6 = await controller.upload(image5);
                                  imagess[5] = url6;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[5] = url6;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image6.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image6.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image6 = File("");
                                          setState(() {});
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
                                  image6 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url7 = await controller.upload(image6);
                                  imagess[6] = url7;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[6] = url7;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image6 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url7 = await controller.upload(image6);
                                  imagess[6] = url7;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[6] = url7;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image7.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image7.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image7 = File("");
                                          setState(() {});
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
                                  image7 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url8 = await controller.upload(image7);
                                  imagess[7] = url8;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[7] = url8;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image7 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url8 = await controller.upload(image7);
                                  imagess[7] = url8;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[7] = url8;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: image8.path.isNotEmpty
                        ? Stack(children: [
                            Image.file(
                              File(image8.path.toString()),
                              fit: BoxFit.contain,
                              height: 120,
                              width: Get.width,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image8 = File("");
                                          setState(() {});
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
                                  image8 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url9 = await controller.upload(image8);
                                  imagess[8] = url9;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[8] = url9;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image8 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url9 = await controller.upload(image8);
                                  imagess[8] = url9;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[8] = url9;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class CustomProperty1 extends StatefulWidget {
  CustomPropertyState1 createState() => CustomPropertyState1();
  CustomProperty1(
      {this.data,
      this.name,
      required this.index,
      required this.images,
      this.units,
      this.floor,
      this.appliences,
      this.windows,
      this.doors,
      this.imgurl,
      this.celling,
      this.walls});
  List<PropertyDetails>? data;
  String? name;
  String? units;
  var imgurl;
  String? celling;
  String? floor;
  String? appliences;
  String? windows;
  String? doors;
  String? walls;

  int index;
  List<List<String>> images;
}

class CustomPropertyState1 extends State<CustomProperty1> {
  late String url1;
  late String url2;
  late String url3;
  late String url4;
  late String url5;
  late String url6;
  late String url7;
  late String url8;
  late String url9;
  List<String> imagess = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  File image = File("");
  File image1 = File("");
  File image2 = File("");
  File image3 = File("");
  File image4 = File("");
  File image5 = File("");
  File image6 = File("");
  File image7 = File("");
  File image8 = File("");
  TextEditingController et1 = TextEditingController();
  TextEditingController et2 = TextEditingController();
  TextEditingController et3 = TextEditingController();
  TextEditingController et4 = TextEditingController();
  TextEditingController et5 = TextEditingController();
  TextEditingController et6 = TextEditingController();
  TextEditingController et7 = TextEditingController();
  TextEditingController et8 = TextEditingController();
  PropertyDetails? pd;

  final controller = Get.find<AddDataController>();
  int i = 0;
  void initState() {
    super.initState();
    pd = PropertyDetails();
    widget.data?.add(pd!);
    widget.data?[widget.index] = pd!;
    widget.data?[widget.index].name = widget.name;
    widget.data?[widget.index].images = imagess;
    widget.data = widget.data?.toSet().toList();
    et2.text = "Fair";
    et3.text = "Fair";
    et4.text = "Fair";
    et6.text = "Fair";
    et7.text = "Fair";
    et8.text = "Fair";
    imagess[0] = widget.imgurl[0].url.toString();
    imagess[1] = widget.imgurl[1].url.toString();
    imagess[2] = widget.imgurl[2].url.toString();
    imagess[3] = widget.imgurl[3].url.toString();
    imagess[4] = widget.imgurl[4].url.toString();
    imagess[5] = widget.imgurl[5].url.toString();
    imagess[6] = widget.imgurl[6].url.toString();
    imagess[7] = widget.imgurl[7].url.toString();
    imagess[8] = widget.imgurl[8].url.toString();
    widget.data?[widget.index].images?[0] = widget.imgurl[0].url.toString();
    widget.data?[widget.index].images?[1] = widget.imgurl[1].url.toString();
    widget.data?[widget.index].images?[2] = widget.imgurl[2].url.toString();
    widget.data?[widget.index].images?[3] = widget.imgurl[3].url.toString();
    widget.data?[widget.index].images?[4] = widget.imgurl[4].url.toString();
    widget.data?[widget.index].images?[5] = widget.imgurl[5].url.toString();
    widget.data?[widget.index].images?[6] = widget.imgurl[6].url.toString();
    widget.data?[widget.index].images?[7] = widget.imgurl[7].url.toString();
    widget.data?[widget.index].images?[8] = widget.imgurl[8].url.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    widget.walls != null
        ? et2.text = widget.walls.toString()
        : et2.text = "Fair";
    widget.windows != null
        ? et3.text = widget.windows.toString()
        : et3.text = "Fair";
    widget.floor != null
        ? et8.text = widget.floor.toString()
        : et8.text = "Fair";
    widget.doors != null
        ? et4.text = widget.doors.toString()
        : et4.text = "Fair";
    widget.units != null
        ? et6.text = widget.units.toString()
        : et6.text = "Fair";
    widget.appliences != null
        ? et7.text = widget.appliences.toString()
        : et7.text = "Fair";

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 15),
      width: Get.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  controller.count.value = 1;
                  controller.items.remove(widget.index);
                  if (widget.index >= 7) {
                    controller.list.value--;
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Text(
            widget.name.toString(),
            style:
                TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: et1,
            onTapOutside: (a) {
              if (et1.text.isNotEmpty) {
                widget.data?[widget.index].name = et1.text;
              }
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: widget.name),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                TextField(
                  controller: et2,
                  onTapOutside: (a) {
                    if (et2.text.isNotEmpty) {
                      widget.data?[widget.index].walls = et2.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Walls:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                if (widget.name == "Kitchen") ...[
                  TextField(
                    controller: et6,
                    onTapOutside: (a) {
                      if (et6.text.isNotEmpty) {
                        widget.data?[widget.index].units = et6.text;
                      }
                    },
                    decoration: InputDecoration(
                      icon: Text("Units:"),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  TextField(
                    controller: et7,
                    onTapOutside: (a) {
                      if (et7.text.isNotEmpty) {
                        widget.data?[widget.index].appliances = et7.text;
                      }
                    },
                    decoration: InputDecoration(
                      icon: Text("Appliances:"),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                ],
                TextField(
                  controller: et3,
                  onTapOutside: (a) {
                    if (et3.text.isNotEmpty) {
                      widget.data?[widget.index].windows = et3.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Windows:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  controller: et8,
                  onTapOutside: (a) {
                    if (et8.text.isNotEmpty) {
                      widget.data?[widget.index].floor = et8.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Floors:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  controller: et4,
                  onTapOutside: (a) {
                    if (et4.text.isNotEmpty) {
                      widget.data?[widget.index].doors = et4.text;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Text("Doors:"),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Other Details",
            style:
                TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: et5,
            onTapOutside: (a) {
              if (et5.text.isNotEmpty) {
                widget.data?[widget.index].description = et5.text;
              }
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Descriptions"),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Upload Images"),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[0].url.contains("upload") ||
                            image.path.isNotEmpty
                        ? Stack(children: [
                            image.path.isNotEmpty
                                ? Image.file(
                                    File(image.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[0].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            image = File("");
                                            widget.imgurl[0].url = "";
                                          });
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
                                  image = await controller.pickImages();
                                  setState(() {});
                                  url1 = await controller.upload(image);
                                  imagess[0] = url1;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[0] = url1;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image = await controller.pickImageGallerys();
                                  setState(() {});
                                  if (image != null) {
                                    url1 = await controller.upload(image);
                                    imagess[0] = url1;
                                    imagess = imagess.toSet().toList();
                                    // widget.data?[widget.index].images = imagess;
                                    widget.data?[widget.index].images?[0] =
                                        url1;
                                  }
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[1].url.contains("upload") ||
                            image1.path.isNotEmpty
                        ? Stack(children: [
                            image1.path.isNotEmpty
                                ? Image.file(
                                    File(image1.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[1].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            image1 = File("");
                                            widget.imgurl[1].url = "";
                                          });
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
                                  image1 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url2 = await controller.upload(image1);
                                  imagess[1] = url2;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[1] = url2;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image1 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url2 = await controller.upload(image1);
                                  imagess[1] = url2;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[1] = url2;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[2].url.contains("upload") ||
                            image2.path.isNotEmpty
                        ? Stack(children: [
                            image2.path.isNotEmpty
                                ? Image.file(
                                    File(image2.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[2].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            image2 = File("");
                                            widget.imgurl[2].url = "";
                                          });
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
                                  image2 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url3 = await controller.upload(image2);
                                  imagess[2] = url3;
                                  print(imagess[2]);
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[2] = url3;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image2 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url3 = await controller.upload(image2);
                                  imagess[2] = url3;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[2] = url3;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[3].url.contains("upload") ||
                            image3.path.isNotEmpty
                        ? Stack(
                            children: [
                              image3.path.isNotEmpty
                                  ? Image.file(
                                      File(image3.path.toString()),
                                      fit: BoxFit.contain,
                                      height: 120,
                                      width: Get.width,
                                    )
                                  : Image.network(
                                      Paths.baseUrl +
                                          "/" +
                                          widget.imgurl[3].url.toString(),
                                      fit: BoxFit.contain,
                                      height: 120,
                                      width: Get.width,
                                    ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5, top: 5),
                                  child: InkWell(
                                    onTap: () {
                                      image3 = File("");
                                      widget.imgurl[3].url = "";
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  image3 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url4 = await controller.upload(image3);
                                  imagess[3] = url4;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[3] = url4;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image3 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url4 = await controller.upload(image3);
                                  imagess[3] = url4;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[3] = url4;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[4].url.contains("upload") ||
                            image4.path.isNotEmpty
                        ? Stack(children: [
                            image4.path.isNotEmpty
                                ? Image.file(
                                    File(image4.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[4].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image4 = File("");
                                          widget.imgurl[4].url = "";
                                          setState(() {});
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
                                  image4 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url5 = await controller.upload(image4);
                                  imagess[4] = url5;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[4] = url5;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image4 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url5 = await controller.upload(image4);
                                  imagess[4] = url5;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[4] = url5;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[5].url.contains("upload") ||
                            image5.path.isNotEmpty
                        ? Stack(children: [
                            image5.path.isNotEmpty
                                ? Image.file(
                                    File(image5.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[5].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image5 = File("");
                                          widget.imgurl[5].url = "";
                                          setState(() {});
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
                                  image5 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url6 = await controller.upload(image5);
                                  imagess[5] = url6;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[5] = url6;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image5 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url6 = await controller.upload(image5);
                                  imagess[5] = url6;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[5] = url6;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[6].url.contains("upload") ||
                            image6.path.isNotEmpty
                        ? Stack(children: [
                            image6.path.isNotEmpty
                                ? Image.file(
                                    File(image6.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[6].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image6 = File("");
                                          widget.imgurl[6].url = "";
                                          setState(() {});
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
                                  image6 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url7 = await controller.upload(image6);
                                  imagess[6] = url7;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[6] = url7;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image6 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url7 = await controller.upload(image6);
                                  imagess[6] = url7;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[6] = url7;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[7].url.contains("upload") ||
                            image7.path.isNotEmpty
                        ? Stack(children: [
                            image7.path.isNotEmpty
                                ? Image.file(
                                    File(image7.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[7].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image7 = File("");
                                          widget.imgurl[7].url = "";
                                          setState(() {});
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
                                  image7 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url8 = await controller.upload(image7);
                                  imagess[7] = url8;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[7] = url8;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image7 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url8 = await controller.upload(image7);
                                  imagess[7] = url8;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[7] = url8;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.imgurl[8].url.contains("upload") ||
                            image8.path.isNotEmpty
                        ? Stack(children: [
                            image8.path.isNotEmpty
                                ? Image.file(
                                    File(image8.path.toString()),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  )
                                : Image.network(
                                    Paths.baseUrl +
                                        "/" +
                                        widget.imgurl[8].url.toString(),
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: Get.width,
                                  ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: InkWell(
                                        onTap: () {
                                          image8 = File("");
                                          widget.imgurl[8].url = "";
                                          setState(() {});
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
                                  image8 = await controller.pickImages();
                                  setState(() {
                                    print("ff");
                                  });
                                  url9 = await controller.upload(image8);
                                  imagess[8] = url9;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[8] = url9;
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () async {
                                  image8 = await controller.pickImageGallerys();
                                  setState(() {
                                    print("ff");
                                  });
                                  url9 = await controller.upload(image8);
                                  imagess[8] = url9;
                                  imagess = imagess.toSet().toList();
                                  // widget.data?[widget.index].images = imagess;
                                  widget.data?[widget.index].images?[8] = url9;
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 32,
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
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
