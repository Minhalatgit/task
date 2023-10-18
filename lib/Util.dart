import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Util {
  static String? emailValidate(String? value) {
    if (value == null) return null;
    if (value.isEmpty == true || value == "") {
      return "Email is required";
    } else if (!EmailValidator.validate(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  static String? nameValidate(String? value) {
    if (value == null) return null;
    if (value.isEmpty || value == "") {
      return "Full name is required";
    } else {
      return null;
    }
  }

  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String? validateValue(String value, String type) {
    value = value.trim();

    if (value.isEmpty || value == "") {
      return "$type is required";
    } else {
      return null;
    }
  }
}
