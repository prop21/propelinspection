import 'package:InventoryWise/models/authmodel/auth_model.dart';
import 'package:InventoryWise/views/home_screen/home_screen.dart';
import 'package:InventoryWise/views/login/login_screen.dart';
import 'package:get/get.dart';
import '../../http/api_response_handler.dart';
import '../../utils/global.dart';

class AuthenticationService {
  Future<AuthModel> login(email, pass) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    try {
      var res = await _http?.post(Paths.authBaseUrl,
          body: {"email": email, "password": pass, "": "true"});
      AuthModel model = AuthModel.fromJson(res);
      Authenticator().setUserToken(model.jwtToken);
      Authenticator().setUserID(model.id.toString());
      return model;
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
      return AuthModel();
    }
  }

  Future<void> forget(email) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    try {
      var res = await _http?.get(
        Paths.forgotBaseUrl,
        queryParameters: {"email": email},
      );
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
    }
  }

  Future<void> reset(email) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    try {
      var res = await _http?.get(
        Paths.resetBaseUrl,
        queryParameters: {"email": email},
      );
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
    }
  }

  Future<void> register(
      title,
      firstname,
      lastname,
      email,
      confirmpassword,
      password,
      acceptterm,
      companyaddress,
      logo,
      company_name,
      company_email,
      company_mobile) async {
    var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
    try {
      var res = await _http?.post(Paths.registerbaseUrl, body: {
        "title": title,
        "firstName": firstname,
        "lastName": lastname,
        "email": email,
        "confirmPassword": confirmpassword,
        "password": password,
        "acceptTerms": acceptterm,
        "company_logo": logo,
        "company_address": confirmpassword,
        "mobile_number": company_mobile,
        "company_name": company_name,
        "company_email": company_email
      });
      Register model = Register.fromJson(res);
      AuthModel m = await login(email, password);
      Authenticator().setUserID(m.id.toString());
      Get.offAll(() => Login_Screen());
      Get.defaultDialog(title: "Message", middleText: model.message.toString());
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
