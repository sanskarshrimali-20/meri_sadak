import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/utils/device_size.dart';
import '../constants/app_dimensions.dart';

class CustomLoginSignupBgUnActiveWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final VoidCallback onClick;
  final double borderWidth; // Border width to control the thickness of the border

  // Constructor to accept parameters for customization
  const CustomLoginSignupBgUnActiveWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.textAlign = TextAlign.center, // Default text alignment is center
    this.fontWeight = FontWeight.w400, // Default fontWeight is normal
    this.letterSpacing,
    required this.onClick,
    this.borderWidth = 0.5, // Default border width
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick, // Trigger the onClick callback when the container is tapped
      child: Container(
        padding: EdgeInsets.all(1),
        height: AppDimensions.di_60,
        width: DeviceSize.getScreenWidth(context) * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.di_40), // Rounded corners
          ),
        ),
        child: Stack(
          children: [
            // First border layer (outermost border)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.di_40),
                ),
                border: Border.all(
                  color: AppColors.blueGradientColor1, // First border color
                  width: borderWidth,
                ),
              ),
            ),
            // Second border layer
            if (2 > 1) // If there are multiple colors
              Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.all(borderWidth), // Apply margin to create space between borders
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.di_40),
                  ),
                  border: Border.all(
                    color: AppColors.blueGradientColor2, // Second border color
                    width: borderWidth,
                  ),
                ),
              ),
            // Inner content container
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.all(borderWidth * 2), // Adjust the margin to create space between inner content and border
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.di_40),
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: fontSize,
                    fontWeight: AppFontWeight.fontWeight500,
                    letterSpacing: letterSpacing,
                  ),
                  textAlign: textAlign, // Align text horizontally
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
