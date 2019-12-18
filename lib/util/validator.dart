import 'dart:core';

import 'all_translation.dart';

class ValidationMixin {

  String validatePassword(String val) {
    if (val.isEmpty) {
      return allTranslations.text("VALID_REQUIRED");
    } else if (val.length < 6) {
      return 'Password ${allTranslations.text("VALID_LENGTH")}';
    }
    return null;
  }

  String validateEmail(String val) {
    if (val.isEmpty) {
      return allTranslations.text("VALID_REQUIRED");
    } else if (!val.contains("@") && !val.contains(".")) {
      return allTranslations.text("VALID_EMAIL");
    }
    return null;
  }

  String validateRequired(String val) {
    if (val.isEmpty) {
      return allTranslations.text("VALID_REQUIRED");
    }
    return null;
  }
  
  String validateRequiredInteger(int val) {
    print(val);
    if (val == null || val.isNaN) {
      return allTranslations.text("VALID_REQUIRED");
    }
    return null;
  }

  String validateRequiredNumber(String val) {
    if (val.isEmpty) {
      return allTranslations.text("VALID_REQUIRED");
    } else if (!isNumeric(val)) {
      return allTranslations.text("VALID_NUMBER");
    }
    return null;
  }

  String validateNumber(String val) {
    if (val.isNotEmpty && !isNumeric(val)) {
      return allTranslations.text("VALID_NUMBER");
    }
    return null;
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }


}