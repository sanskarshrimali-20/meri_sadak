import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';

import '../constants/app_dimensions.dart';

Widget customPasswordWidget({
  required TextEditingController textEditController,
  required String hintText,
  bool isPassword = false,
  required bool isPasswordVisible,
  VoidCallback? togglePasswordVisibility,
  bool showPrefixIcon = true,  // Add this parameter to control prefix icon visibility
}) {
  return TextField(
    keyboardType: TextInputType.emailAddress, // You can adjust this based on the use case
    maxLines: 1,
    controller: textEditController,
    obscureText: isPassword ? !isPasswordVisible : false,
    style: const TextStyle(color: Colors.black),
    maxLength: 20,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withAlpha(200), // Darken the fill color
      hintText: hintText,
      counterText: "",
      hintStyle: const TextStyle(color: Colors.black54, fontSize: AppDimensions.di_16),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(AppDimensions.di_9),
        child: SvgPicture.asset(
          ImageAssetsPath.lock2,  // Path to the custom icon image
         width: AppDimensions.di_20, // Adjust the width of the image
          height: AppDimensions.di_20, // Adjust the height of the image
        ),
      ),
      suffixIcon: isPassword
          ? IconButton(
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
        onPressed: togglePasswordVisibility,
      )
          : null,
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
