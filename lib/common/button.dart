import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  danger,
  warning,
  text,
}

class AppButtonThemes {
  AppButtonThemes._();

  static ButtonStyle secondary = TextButton.styleFrom(
    // primary: Colors.white,
    textStyle: TextStyle(color: Colors.blue),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.blue.shade200, width: 2.0),
    ),
  );
}
