import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_signature_pad/easy_signature_pad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/addproperty/add_proprert_model.dart';
import '../../../models/homedata/Home_Data.dart';
import '../../../service/home/home_service.dart';

class AddDataController extends GetxController {
  late CameraController controller;
  var service = HomeService();
  RxInt count = 17.obs;
  int delid = 0;
  var list = 14.obs;
  var temp = File("");
  var temp1 = File("");
  var index = 0.obs;
  var items = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ].obs;
  var type = "Inventory Report".obs;
  var t1 = "Yes".obs;
  var t2 = "Yes".obs;
  var t3 = "Yes".obs;
  var t4 = "Yes".obs;
  var t5 = "Yes".obs;
  var t6 = "Yes".obs;
  var sig1 = File("").obs;
  var sig2 = File("").obs;

  List<TextEditingController> f = [];

  TextEditingController propertyAddressController = TextEditingController();
  TextEditingController tenantNameController = TextEditingController();
  TextEditingController inspectorNameController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();
  TextEditingController epcExpiryDateController = TextEditingController();
  TextEditingController ecirExpiryDateController = TextEditingController();
  TextEditingController gasSafetyCertificateExpiryDateController =
      TextEditingController();
  TextEditingController electricityMeterController = TextEditingController();
  TextEditingController gasMeterController = TextEditingController();
  TextEditingController smokeAlarmController = TextEditingController();
  TextEditingController coAlarmController = TextEditingController();
  TextEditingController heatingSystemController = TextEditingController();
  TextEditingController signatureInspectorController = TextEditingController();
  TextEditingController advisedTenantToController = TextEditingController();
  TextEditingController askedLandlordToController = TextEditingController();
  TextEditingController gasMeterReadingController = TextEditingController();
  TextEditingController electricityMeterReadingController =
      TextEditingController();

  TextEditingController signatureTenantController = TextEditingController();
  TextEditingController finalRemarksController = TextEditingController();
  TextEditingController waterMeterController = TextEditingController();
  TextEditingController mainImgController = TextEditingController();
  TextEditingController waterMeterReadingController = TextEditingController();
  TextEditingController electricityMeterImgController = TextEditingController();
  TextEditingController gasMeterImgController = TextEditingController();
  TextEditingController waterMeterImgController = TextEditingController();
  TextEditingController smokeAlarmFrontImgController = TextEditingController();
  TextEditingController smokeAlarmBackImgController = TextEditingController();
  TextEditingController coAlarmFrontImgController = TextEditingController();
  TextEditingController coAlarmBackImgController = TextEditingController();
  TextEditingController heatingSystemImgController = TextEditingController();
  String? mainimage;
  String? electricmeterfront;
  String? gasmeterfront;
  String? watermeterfront;
  String? smokealarmfront;
  String? smokealarmback;
  String? coalarmfront;
  String? coalarmback;
  String? heatingsystem;
  var maini = File("").obs;
  var electric = File("").obs;
  var gasmeter = File("").obs;
  var watermeter = File("").obs;
  var smokealarm = File("").obs;
  var smokealar = File("").obs;
  var coalarm = File("").obs;
  var coal = File("").obs;
  var heating = File("").obs;
  String? inspector;
  String? tenant;
  RxInt se = 0.obs;
  var main = File("").obs;

  RxList<File> image = <File>[].obs;
  var images = File("").obs;
  List<String?> urls = [];
  var loading = true.obs;

  Future pickImages() async {
    try {
      final imagedata =
          await ImagePicker().getImage(source: ImageSource.camera);
      if (imagedata == null) return;
      final imageTemp = File(imagedata.path);
      return imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageGallerys() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File image = File(pickedFile!.path);
      if (image == null) return;

      final imageTemp = File(image.path);
      this.images.value = imageTemp;
      return this.images.value;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    for (int i = 0; i <= 500; i++) {
      image.add(File(""));
    }
    for (int i = 0; i <= 500; i++) {
      urls.add("");
    }
    for (int i = 0; i <= 500; i++) {
      f.add(TextEditingController());
    }

    loading.value = false;
  }

  void addData(prop) async {
    await service.addProperty(
        f,
        urls,
        mainimage,
        electricmeterfront,
        gasmeterfront,
        watermeterfront,
        smokealarmfront,
        smokealarmback,
        coalarmfront,
        coalarmback,
        heatingsystem,
        tenant,
        inspector,
        prop,
        advisedTenantToController.text,
        askedLandlordToController.text,
        finalRemarksController.text,
        t1.value,
        t2.value,
        t3.value,
        t4.value,
        t5.value,
        t6.value,
        type.value);
  }

  void updateData(prop, id) async {
    await service.updateProperty(
        id,
        f,
        urls,
        mainimage,
        electricmeterfront,
        gasmeterfront,
        watermeterfront,
        smokealarmfront,
        smokealarmback,
        coalarmfront,
        coalarmback,
        heatingsystem,
        tenant,
        inspector,
        prop,
        advisedTenantToController.text,
        askedLandlordToController.text,
        finalRemarksController.text,
        t1.value,
        t2.value,
        t3.value,
        t4.value,
        t5.value,
        t6.value,
        type.value);
  }

  void deleteData(prop, id) async {
    await service.deleteProperty(
      id,
    );
  }

  void bottomSheet(val) {
    temp = val;
    Get.bottomSheet(
      isDismissible: false,
      barrierColor: Colors.transparent,
      Column(
        children: [
          Transform.translate(
            offset: Offset(0, 10),
            child: Container(
                color: Colors.white,
                width: Get.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          inspector = await upload(sig1.value);
                          Get.back();
                        },
                        child: Text("Save"),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      MaterialButton(
                        onPressed: () {
                          sig1.value = temp;
                          temp = val;
                          Get.back();
                        },
                        child: Text("Cancel"),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ])),
          ),
          Flexible(
            child: EasySignaturePad(
              onChanged: (image) async {
                sig1.value = File("");
                Uint8List convertedBytes = base64Decode(image);
                final tempDir = await getTemporaryDirectory();
                sig1.value = await File('${tempDir.path}/${DateTime.now()}.png')
                    .create();
                sig1.value.writeAsBytesSync(convertedBytes);
              },
              height: Get.height ~/ 2,
              width: Get.width ~/ 1,
              penColor: Colors.black,
              strokeWidth: 5.0,
              // borderRadius: 10.0,
              borderColor: Colors.transparent,
              backgroundColor: Colors.white,
              transparentImage: false,
              transparentSignaturePad: false,
              hideClearSignatureIcon: false,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      enableDrag: false,
    );
  }

  void bottomSheet1(val) {
    temp1 = val;
    Get.bottomSheet(
      Column(children: [
        Transform.translate(
          offset: Offset(0, 10),
          child: Container(
            width: Get.width,
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      tenant = await upload(sig2.value);
                      Get.back();
                    },
                    child: Text("Save"),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  MaterialButton(
                    onPressed: () {
                      sig2.value = temp1;
                      temp1 = val;
                      Get.back();
                    },
                    child: Text("Cancel"),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ]),
          ),
        ),
        Flexible(
          child: EasySignaturePad(
            onChanged: (image) async {
              sig2.value = File("");
              Uint8List convertedBytes = base64Decode(image);
              final tempDir = await getTemporaryDirectory();
              sig2.value =
                  await File('${tempDir.path}/${DateTime.now()}.png').create();
              sig2.value.writeAsBytesSync(convertedBytes);
            },
            height: Get.height ~/ 2,
            width: Get.width ~/ 1,
            penColor: Colors.black,
            strokeWidth: 5.0,
            // borderRadius: 10.0,
            borderColor: Colors.transparent,
            backgroundColor: Colors.white,
            transparentImage: false,
            transparentSignaturePad: false,
            hideClearSignatureIcon: false,
          ),
        ),
      ]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      isDismissible: false,
      barrierColor: Colors.transparent,
      enableDrag: false,
    );
  }

  Future<String> upload(images) async {
    return await service.uploadImage(images.path);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
