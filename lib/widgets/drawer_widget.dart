import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';

Widget customDrawerWidget({
  required String title,
  required String icon,
  Color iconColor = Colors.black,
  Color textColor = Colors.black,
  Color suffixIconColor = Colors.black,
  bool visible = true,
  bool logoutVisible = true,
  bool prefixVisible = true,
  required VoidCallback onClick, // Add the callback here
}) {
  return // Trigger the callback when clicked
  Container(
    padding: EdgeInsets.only(
      left: AppDimensions.di_10,
      right: AppDimensions.di_10,
      top: AppDimensions.di_5,
      bottom: AppDimensions.di_5,
    ),
    child: GestureDetector(
      onTap: onClick,
      child: Row(
        children: [
          // Image before text
          prefixVisible ? SvgPicture.asset(icon, color: iconColor) : SvgPicture.asset(""),
          SizedBox(width: AppDimensions.di_18),
          // Text in the middle
          Text(
            title,
            style: TextStyle(fontSize: AppDimensions.di_17, color: textColor),
          ),
          Spacer(),
          // Image after text (arrow icon)
          visible
              ? SvgPicture.asset(ImageAssetsPath.rightArrow, color: suffixIconColor,)
              : SvgPicture.asset(""),
          logoutVisible
              ? Text("")
              : Text(
                "V 6.2.4",
                style: TextStyle(fontSize: AppDimensions.di_17),
              ),
        ],
      ),
    ),
  );
}
