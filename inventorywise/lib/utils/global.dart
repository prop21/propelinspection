final Authenticator authenticator = Authenticator();

class ModuleIDs {
  static const String login = "SIGN-IN";
  static const String register = "SIGN-UP";
  static const String addNumberEmail = "ADD-NEW-EMAIL-OR-PHONE";
  static const String forgotUser = "forgotUser";
  static const String forgotPin = "FORGOT-PIN";
}

class GreetingIDs {
  static const String goodMorning = "GM";
  static const String goodAfternoon = "GA";
  static const String goodEvening = "GE";
  static const String goodNight = "GN";
}

class UserType {
  static const String phone = "PHONE";
  static const String email = "EMAIL";
}

class PaymentType {
  static const String credit = "CREDIT CARD";
  static const String debit = "DEBIT CARD";
}

class Cards {
  static const String visa = "visa";
  static const String master = "master";
  static const String visaCard = "visacard";
  static const String masterCard = "mastercard";
}

class Paths {

  // static String baseUrl = 'http://52.221.239.76:9191'; //development
  static String baseUrl = 'https://api.inventorywise.co.uk';
  static String authBaseUrl = '$baseUrl/accounts/authenticate';
  static String registerbaseUrl = '$baseUrl/accounts/register';
  static String propertiesBaseUrl = '$baseUrl/properties/getByUserId/';
  static String resetBaseUrl = '$baseUrl/accounts/reset-password';
  static String forgotBaseUrl = '$baseUrl/accounts/forgot-password';
  static String addPropertiesBaseUrl = "$baseUrl/properties/";
  static String updatePropertiesBaseUrl = "$baseUrl/properties/";
  static String deletePropertiesBaseUrl = "$baseUrl/properties/";
  static String uploadImageBaseUrl = '$baseUrl/properties/upload_image';
}

class Authenticator {
  static final Authenticator _authenticator = Authenticator._internal();

  factory Authenticator() {
    return _authenticator;
  }

  Authenticator._internal();

  String? _userToken;
  String? _otpToken;
  String? _userID;
  String? _ipAddress;
  String? _email;
  String? _logo;

  void setOtpToken(String? token) {
    _otpToken = token; //'bearer $token';
  }

  void setLogo(String? logo) {
    _logo = logo; //'bearer $token';
  }

  void setEmail(String? email) {
    _email = email; //'bearer $token';
  }

  void setUserToken(String? token) {
    _userToken = token; //'bearer $token';
  }

  void setUserID(String? userID) {
    _userID = userID;
  }

  void setIpAddress(String? ipAddress) {
    _ipAddress = ipAddress;
  }

  resetUser() {
    _otpToken = null;
    _userToken = null;
    _userID = null;
  }

  String? getIpAddress() {
    return _ipAddress;
  }

  String? getLogo() {
    return _logo;
  }

  String? getEmail() {
    return _email;
  }

  String? getOtpToken() {
    if (_otpToken != null) {
      return _otpToken;
    } else {
      return null;
    }
  }

  String? getUserToken() {
    if (_userToken != null) {
      return _userToken;
    } else {
      return null;
    }
  }

  String? getUserID() {
    if (_userID != null) {
      return _userID;
    } else {
      return null;
    }
  }
}
