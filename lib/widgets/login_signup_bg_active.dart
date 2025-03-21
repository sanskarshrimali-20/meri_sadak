import 'package:flutter/material.dart';
import 'package:meri_sadak/utils/device_size.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class CustomLoginSignupBgActiveWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final VoidCallback onClick; // Add the callback here
  final bool isEnabled; // New property to control whether the button is enabled or disabled

  // Constructor to accept parameters for customization
  const CustomLoginSignupBgActiveWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.textAlign = TextAlign.center, // Default text alignment is center
    this.fontWeight = FontWeight.w400, // Default fontWeight is normal
    this.letterSpacing,
    required this.onClick,
    this.isEnabled = true, // Default isEnabled value is true (enabled)
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onClick : null, // Disable the onClick callback if isEnabled is false
      child: Container(
        padding: EdgeInsets.all(AppDimensions.di_1),
        height: AppDimensions.di_60,
        width: DeviceSize.getScreenWidth(context) * 0.85,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.blueGradientColor1, // Gradient Start Color
              AppColors.blueGradientColor2, // Gradient End Color
            ],
          )
              : LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.blueGradientColor1.withAlpha(80), // Gradient Start Color
              AppColors.blueGradientColor2.withAlpha(80), // Gradient End Color
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.di_40), // Rounded corners
          ),
        ),
        child: Center( // This will center the text vertically and horizontally
          child: Text(
            text,
            style: TextStyle(
              color:  color , // Change text color when disabled
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing, // Optional: Use if you want to add letter spacing
            ),
            textAlign: textAlign, // Align text horizontally
          ),
        ),
      ),
    );
  }
}
