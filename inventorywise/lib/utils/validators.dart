import 'package:InventoryWise/utils/formatters.dart';



class Validators {
  static final _instance = Validators._internal();
  factory Validators() => _instance;
  Validators._internal();
  String? validateCVV(String? value) {
    var message = "CVV is required";

    if (value!.isEmpty) {
      return message;
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  String? validateCardNumWithLuhnAlgorithm(String? input) {
    var message = "Card Number is required";
    var invalidMsg = "Card Number is invalid";
    if (input!.isEmpty) {
      return message;
    }

    input = CardFormatter().getCleanedNumber(input);

    if (input!.length < 8) {
      // No need to even proceed with the validation if it's less than 8 characters
      return invalidMsg;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return invalidMsg;
  }

  String? validateCardExpDate(String? value) {
    var message = "Card Exp is required";
    if (value!.isEmpty) {
      return message;
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(RegExp(r'(\/)'))) {
      var split = value.split(RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid year should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is less than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently, is greater than card's
    // year
    return fourDigitsYear < now.year;
  }

  String? validateEmail(String? value, {bool optional = false}) {
    var message = "Email is required";
    if (value!.isEmpty) {
      if (optional) {
        return null;
      }
      message = message;
    } else {
      // Regex condition and messages
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (!emailValid) {
        message = "Valid email is required";

      } else {
        return null;
      }
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);
    return message;
  }

  String? required(String? value) {
    var message = "Required";
    if (value!.isEmpty || value == (null)) {
      message = message;
    } else {
      return null;
    }
    // showSnackbar(cache.scaffoldState, cache.appContext, message);
    return message;
  }

  String? validatePassword(String? value) {
    var message = "Password is required";
    if (value!.isEmpty || value == (null)) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  lengthValidator(String value, List<int> length) {
    bool result = false;
    for (int i = 0; i < length.length; i++) {
      if (value.length == length[i]) {
        result = true;
      }
    }
    return result;
  }

  String? validateCnicSnackBar(String value) {
    var message = "CNIC is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.contains('.') ||
        value.contains(',') ||
        value.contains('-') ||
        !lengthValidator(value, [11, 13])) {
      message = "Valid CNIC is required";
    } else {
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateLoginIDSnackBar(String value) {
    var message = "Login ID is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.length < 3 || value.length > 16) {
      message = "Please enter valid login id.";
    } else {
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateConsumerNoSnackBar(String value, int noOfDigits) {
    var message = "Consumer Number is required";
    if (value.isEmpty || value == null) {
      message = message;
    } else if (value.contains('.') ||
        value.contains(',') ||
        value.contains('-') ||
        value.length != noOfDigits) {
      message = "Valid Consumer Number is required";
    } else {
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateAccountNumberSnackBar(String value) {
    var message = "Account number is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.contains(r'[.-]') || value.length < 14) {
      message = "Valid account number is required";
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateLoginIdSnackBar(String value) {
    var message = "Login id is required";
    if (value.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateMobileNumber(String? value, int size) {
    var message = "Mobile number is required";
    if (value!.isEmpty) {
      message = message;
    } else if (value.contains(r'[.-]') || value.length < size) {
      message = "Valid mobile number is required";

    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateAccountOrIBAN(String value, bool isIban, int minLength) {
    String type = isIban ? "IBAN" : "Account";
    var message = "$type is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.length < minLength) {
      // Regex condition and messages
      message = " $type length cannot be less than $minLength";
    } else {
      // Regex condition and messages
      return null;
    }

    return message;
  }

  String? validateAmount(String value, {double? min, double? max}) {
    var message = "Amount is required";
    if (value.isEmpty) {
      message = message;
    } else if (min != null && double.parse(value) < min) {
      // Regex condition and messages
      message = "Amount cannot be less than $min";
    } else if (max != null && double.parse(value) > max) {
      // Regex condition and messages
      message = "Amount cannot be greater than $max";
    } else {
      // Regex condition and messages
      return null;
    }
    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateDobSnackBar(String value) {
    var message = "Date of birth is required";
    if (value.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? validateCommentsSnackBar(String value) {
    var message = "Comment is required";
    if (value.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String? isValidUserName(String value) {
    final alphabet = RegExp(r'^[a-zA-Z]+$');

    if (value == (null) || value.isEmpty) {
      return 'Username is required';
    } else if (!alphabet.hasMatch(value[0])) {
      return 'Invalid username';
    }
  }

  String? validateTitle(String? value) {
    var message = "Title is required";
    if (value!.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }
    return message;
  }

  String? validateState(String? value) {
    var message = "State is required";
    if (value!.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }
    return message;
  }

  String? validateCity(String? value) {
    var message = "City is required";
    if (value!.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }
    return message;
  }

  String? validateCountry(String? value) {
    var message = "Country is required";
    if (value!.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }
    return message;
  }

  String? validateStreet(String? value) {
    var message = "Street Address is required";
    if (value!.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }
    return message;
  }

  String? validatePin(String? value) {
    if (value!.isEmpty) {
      return 'PIN is required';
    }
    if (value.length != 4) {
      return 'PIN should be 4 digits';
    }
  }

  String? validatePins(String? value, String pin) {
    if (value!.isEmpty) {
      return 'PIN is required';
    }
    if (value.length != 4) {
      return 'PIN should be 4 digits';
    }
    if (value != pin) {
      return 'Incorrect PIN';
    }
  }
}
