import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/utils/device_size.dart';

void showCustomBaseDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String icon,
  bool iconVisibility = false,
  required VoidCallback onYesPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.di_15),
        ),
        elevation: AppDimensions.di_10,
        child: Container(
          height: DeviceSize.getScreenHeight(context) * 0.5,
          padding: EdgeInsets.all(AppDimensions.di_20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: iconVisibility,  // Control visibility with the boolean
                  child: SvgPicture.asset(
                    icon,  // Path to your SVG file in the assets folder
                    width: AppDimensions.di_60,
                    height: AppDimensions.di_60,
                  ),
                ),
                SizedBox(height: AppDimensions.di_20),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppDimensions.di_22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.di_10),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppDimensions.di_16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: AppDimensions.di_20),

                GestureDetector(
                  onTap: () {
                   /* Navigator.push(context,  MaterialPageRoute(
                      builder: (context) =>

                    ),);*/
                    Navigator.pop(context);  // Dismiss the dialog
                  },
                  child: Image.asset(ImageAssetsPath.logout),// Your image path here
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}