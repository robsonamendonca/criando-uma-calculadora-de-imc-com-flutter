import 'package:flutter/material.dart';

class CustomAlertDialog {
  static alertTyoe (String type, String msg, BuildContext context) {
    var snackMsg = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      backgroundColor: (type == "success") ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackMsg);
  }
}
