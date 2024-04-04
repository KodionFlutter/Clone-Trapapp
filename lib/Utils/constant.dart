import 'package:flutter/material.dart';

// final String Api_Url="http://www.api.trapapp.io/index.cfm"; ///not
// final String Api_Url="http://trapapp.io/trapapp/api/index.cfm"; ///not
// final String Api_Url="http://www.trapapp.io/api/index.cfm"; ///yeah
final String Api_Url="https://api.trapapp.io/index.cfm"; ///yes
var nfcCodeValidation = "/dashboard/nfcCodeValidation";
var AppversionName = "1.0.0";
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Strings {
  static String nfcText =
      "Reader is located along the top\nmiddle, or bottom of the backside of your phone";
}

//! Method's

void showMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
