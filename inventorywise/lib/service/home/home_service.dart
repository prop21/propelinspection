import 'dart:convert';
import 'dart:io';

import 'package:InventoryWise/models/authmodel/auth_model.dart';
import 'package:InventoryWise/models/homedata/Home_Data.dart';
import 'package:InventoryWise/views/home_screen/home_controller.dart';
import 'package:InventoryWise/views/home_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as htttp;
import '../../http/api_response_handler.dart';
import '../../utils/global.dart';

class HomeService {
  Future<HomeData> getData(id) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    try {
      var res = await _http?.get(Paths.propertiesBaseUrl + id);
      HomeData data = HomeData.fromJson(res);

      return data;
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
      return HomeData();
    }
  }

  Future<String> uploadImage(image) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);

    var postUri = Uri.parse(Paths.uploadImageBaseUrl);

    htttp.MultipartRequest request =
        await new htttp.MultipartRequest("POST", postUri);

    htttp.MultipartFile multipartFile =
        await htttp.MultipartFile.fromPath('file', image);

    request.files.add(multipartFile);

    htttp.StreamedResponse response = await request.send();

    var responseString = await response.stream.bytesToString();
    final decodedMap = json.decode(responseString);
    return decodedMap["path"].toString();
  }

  Future<void> addProperty(
      inputFields,
      image,
      mainimage,
      electricmeterfront,
      gasmeterfront,
      watermeterfront,
      smokealarmfront,
      smokealarmback,
      coalarmfront,
      coalarmback,
      heatingsystem,
      tenent,
      inspector,
      prop,
      tenadvise,
      landlo,
      finalre,
      emeter,
      gmeter,
      wmeter,
      smeter,
      cometer,
      hmeter,
      type) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    print(prop);
    try {
      var res = await _http?.post(Paths.addPropertiesBaseUrl, body: {
        "property_details": prop,
        "user_id": Authenticator().getUserID(),
        "property_address": inputFields[0].text,
        "tenant_name": inputFields[1].text,
        "inspector_name": inputFields[2].text,
        "inspectiondate": inputFields[3].text,
        "epc_expiry_date": inputFields[4].text,
        "ecir_expirydate": inputFields[5].text,
        "gas_safety_certificate_expiry_date": inputFields[6].text,
        "electricity_meter": emeter,
        "gas_meter": gmeter,
        "smoke_alarm": smeter,
        "co_alarm": cometer,
        "heating_system": hmeter,
        "signature_inspector": inspector,
        "advised_tenant_to": tenadvise,
        "asked_landlord_to": landlo,
        "contractor_instructed": "true",
        "gas_meter_reading": inputFields[8].text,
        "electricity_meter_reading": inputFields[7].text,
        "types": type,
        "signature_tenant": tenent,
        "final_remarks": finalre,
        "water_meter": wmeter,
        "main_img": mainimage.toString(),
        "water_meter_reading": inputFields[9].text,
        "electricity_meter_img": electricmeterfront,
        "gas_meter_img": gasmeterfront,
        "water_meter_img": watermeterfront,
        "smoke_alarm_front_img": smokealarmfront,
        "smoke_alarm_back_img": smokealarmback,
        "co_alarm_front_img": coalarmfront,
        "co_alarm_back_img": coalarmback,
        "heating_system_img": heatingsystem
      });
      var cont = Get.find<HomeController>();
      cont.getData(Authenticator().getUserID());
      Get.back();
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
    }
  }

  Future<void> updateProperty(
      id,
      inputFields,
      image,
      mainimage,
      electricmeterfront,
      gasmeterfront,
      watermeterfront,
      smokealarmfront,
      smokealarmback,
      coalarmfront,
      coalarmback,
      heatingsystem,
      tenent,
      inspector,
      prop,
      tenadvise,
      landlo,
      finalre,
      emeter,
      gmeter,
      wmeter,
      smeter,
      cometer,
      hmeter,
      type) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    print(prop);
    try {
      var res = await _http
          ?.put(Paths.updatePropertiesBaseUrl + id.toString(), body: {
        "property_details": prop,
        "user_id": Authenticator().getUserID(),
        "property_address": inputFields[0].text,
        "tenant_name": inputFields[1].text,
        "inspector_name": inputFields[2].text,
        "inspectiondate": inputFields[3].text,
        "epc_expiry_date": inputFields[4].text,
        "ecir_expirydate": inputFields[5].text,
        "gas_safety_certificate_expiry_date": inputFields[6].text,
        "electricity_meter": emeter,
        "gas_meter": gmeter,
        "smoke_alarm": smeter,
        "co_alarm": cometer,
        "heating_system": hmeter,
        "signature_inspector": inspector,
        "advised_tenant_to": tenadvise,
        "asked_landlord_to": landlo,
        "contractor_instructed": "true",
        "gas_meter_reading": inputFields[8].text,
        "electricity_meter_reading": inputFields[7].text,
        "types": type,
        "signature_tenant": tenent,
        "final_remarks": finalre,
        "water_meter": wmeter,
        "main_img": mainimage.toString(),
        "water_meter_reading": inputFields[9].text,
        "electricity_meter_img": electricmeterfront,
        "gas_meter_img": gasmeterfront,
        "water_meter_img": watermeterfront,
        "smoke_alarm_front_img": smokealarmfront,
        "smoke_alarm_back_img": smokealarmback,
        "co_alarm_front_img": coalarmfront,
        "co_alarm_back_img": coalarmback,
        "heating_system_img": heatingsystem
      });
      var cont = Get.find<HomeController>();
      cont.getData(Authenticator().getUserID());
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
    }
  }

  Future<void> deleteProperty(
    id,
  ) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    try {
      var res =
          await _http?.delete(Paths.deletePropertiesBaseUrl + id, body: {});
      var cont = Get.find<HomeController>();
      cont.getData(Authenticator().getUserID());
      Get.back();
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
    }
  }
}

class Register {
  String? message;

  Register({this.message});

  Register.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
