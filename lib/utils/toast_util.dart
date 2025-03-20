import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  // Singleton instance
  static final ToastUtil _instance = ToastUtil._internal();

  factory ToastUtil() {
    return _instance;
  }

  ToastUtil._internal();

  void showToastKeyBoard({
    required BuildContext context,
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM, // Default position
    Color backgroundColor = Colors.red, // Toast background color
    Color textColor = Colors.white, // Toast text color
    double fontSize = 20.0, // Font size for toast
  }) {
    // Get the bottom padding (keyboard height) from MediaQuery (for mobile)
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    // If it's mobile and keyboard is visible, adjust the toast position
    final toastGravity = (bottomPadding > 0) ? ToastGravity.CENTER : gravity;

    // Show the toast
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG, // Show the toast for a short time
      gravity: toastGravity, // Position based on keyboard visibility (mobile only)
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}