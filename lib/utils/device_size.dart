import 'package:flutter/material.dart';

class DeviceSize {
  // Function to get the device screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Function to get the device screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
