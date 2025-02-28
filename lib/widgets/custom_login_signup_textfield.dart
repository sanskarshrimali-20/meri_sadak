import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_dimensions.dart';

Widget customLoginSignupTextFieldWidget( {required TextEditingController textEditController, required String hintText, required String icon}) {
  return TextField(
    keyboardType: TextInputType.name,
    controller: textEditController,
    maxLines: 1,
    style: const TextStyle(color: Colors.black),
    maxLength: 1,
    decoration: InputDecoration(
      fillColor: Colors.white.withAlpha(200), // Darken the fill color
      filled: true,
      counterText: "",
      hintText:  hintText,
      hintStyle: const TextStyle(color: Colors.black54, fontSize: AppDimensions.di_17),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(AppDimensions.di_8),
        child: SvgPicture.asset(
          icon,  // Path to the custom icon image
          width: AppDimensions.di_24, // Adjust the width of the image
          height: AppDimensions.di_24, // Adjust the height of the image
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black), // Change focused border color
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey), // Change enabled border color
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey), // Change disabled border color
      ),
    ),
  );
}
