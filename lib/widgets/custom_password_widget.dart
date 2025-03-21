import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

Widget customPasswordWidget({
  required TextEditingController textEditController,
  required String hintText,
  bool isPassword = false,
  required bool isPasswordVisible,
  VoidCallback? togglePasswordVisibility,
  bool showPrefixIcon =
  true, // Add this parameter to control prefix icon visibility
  String? Function(String?)? validator,
  Function(String)? onChanged,
  String? errorText,
  Color backgroundColor = AppColors.whiteColor,
  Color textColor = AppColors.textColor


}) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    // You can adjust this based on the use case
    maxLines: 1,
    controller: textEditController,
    obscureText: isPassword ? !isPasswordVisible : false,
    style: TextStyle(color: textColor),
    maxLength: 25,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9@$!%*?&]')),
    ],
    decoration: InputDecoration(
      filled: true,
      fillColor: backgroundColor,
      // Darken the fill color
      hintText: hintText,
      errorText: errorText,
      counterText: "",
      errorMaxLines: 3,
      // Allow up to 3 lines for error text
      hintStyle:  TextStyle(
          color:textColor,
          fontSize: AppDimensions.di_18,
          fontWeight: FontWeight.w400
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(AppDimensions.di_10),
        child: SvgPicture.asset(
          ImageAssetsPath.passLock, // Path to the custom icon image
          width: AppDimensions.di_18, // Adjust the width of the image
          height: AppDimensions.di_18, // Adjust the height of the image
          color: textColor,
        ),
      ),
      suffixIcon:
      isPassword
          ? IconButton(
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: textColor,
        ),
        onPressed: togglePasswordVisibility,
      )
          : null,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: textColor,
        ), // Change focused border color
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ), // Change enabled border color
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ), // Change disabled border color
      ),
    ),
    validator: validator,
    onChanged: onChanged,
  );
}
