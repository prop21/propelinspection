import 'dart:io';

import 'package:InventoryWise/models/authmodel/auth_model.dart';
import 'package:InventoryWise/views/home_screen/home_screen.dart';
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

  Future<void> register(title, firstname, lastname, email, confirmpassword,
      password, acceptterm, companyaddress, logo) async {
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
        "company_address": confirmpassword
      });
      Register model = Register.fromJson(res);
      AuthModel m = await login(email, password);
      Authenticator().setUserID(m.id.toString());
      Get.offAll(() => Home_Screen(
            id: m.id.toString(),
            fname: firstname,
            lname: lastname,
            email: email,
          ));
      Get.defaultDialog(title: "Message", middleText: model.message.toString());
    } on Exception catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
    }
  }

  //
  // Future<RegisterationResponse> signUp(
  //     {required String mobileNumber,
  //       required String emailAddress,
  //       required Country country,
  //       required Cites city,
  //       required States state,
  //       required String gender,
  //       required String name,
  //       required String address,
  //       required String zip,
  //       required String dob}) async {
  //   var _http = await ApiResponseInjector().httpDataSource(ApiType.defaultApi);
  //   var res = await _http!.post(
  //     Paths.signup,
  //     body: {
  //       "name": name, // "Azeem Khalid",
  //       "email": emailAddress, //"azeemkhssalids0s03s1s2@gmail.com",
  //       "countryId": country.countryId, //3028
  //       "cityId": city.id, //124
  //       "phoneNumber": mobileNumber, // "923323561745",
  //       "status": "ACTIVE",
  //       "type": "CUSTOMER",
  //       "notificationStatus": true,
  //       "stateId": state.stateId, //3212
  //       "gender": gender, // "Male",
  //       "zip": zip, // "75600",
  //       "address": address, // "A-487 Block I",
  //       "dateOfBirth": dob.toString(), // "2022-01-15T18:15:18.582609+05:00"
  //     },
  //   );
  //
  //   RegisterationResponse jsonResp = RegisterationResponse.fromJson(res);
  //   await UserRepo().save(
  //       mobileNumber,
  //       UserDetails(
  //           userID: jsonResp.id?.toString() ?? '',
  //           userToken: jsonResp.token ?? '',
  //           authenticationType: AuthenticationType.none,
  //           mobileNumber: mobileNumber,
  //           emailAddress: emailAddress,
  //           country: country.name!,
  //           city: city.name!,
  //           state: state.name!,
  //           pin: '',
  //           gender: gender,
  //           name: name,
  //           address: address,
  //           zip: '',
  //           dob: dob.toString()));
  //   await UserRepo().saveSelectedMobile(mobileNumber);
  //
  //   // globalCache.customer = jsonResp.customer;
  //   // if (jsonResp.customer!.id != (null)) {
  //   //   authenticator.setUserID(jsonResp.customer!.id);
  //   // }
  //   if (jsonResp.token != null && jsonResp.token!.isNotEmpty) {
  //     authenticator.setUserToken('Bearer ${jsonResp.token!}');
  //   }
  //   if (jsonResp.id != null) {
  //     authenticator.setUserID(jsonResp.id.toString());
  //   }
  //   return jsonResp;
  // }
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
