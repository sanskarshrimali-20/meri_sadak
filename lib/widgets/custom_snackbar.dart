// Function to show error dialog
import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String message, {
  Color backgroundColor = Colors.red,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
    ),
  );
}
