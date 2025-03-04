import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';

Widget customDrawerWidget({
  required String title,
  required String icon,
  required VoidCallback onClick, // Add the callback here
}) {
  return GestureDetector(
    onTap: onClick, // Trigger the callback when clicked
    child: Container(
      padding: EdgeInsets.only(left: AppDimensions.di_10, right: AppDimensions.di_10, top: AppDimensions.di_5, bottom: AppDimensions.di_5),
      child: Row(
        children: [
          // Image before text
          SvgPicture.asset(icon),
          SizedBox(width: AppDimensions.di_18),
          // Text in the middle
          Text(title, style: TextStyle(fontSize: AppDimensions.di_17),),
          Spacer(),
          // Image after text (arrow icon)
          SvgPicture.asset(ImageAssetsPath.rightArrow),
        ],
      ),
    ),
  );
}