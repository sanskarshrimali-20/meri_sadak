import 'package:flutter/material.dart';
import 'package:meri_sadak/utils/device_size.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class CustomDialogButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final VoidCallback? onClick; // Nullable to handle disabled state
  final bool isActive;

  // Constructor to accept parameters for customization
  const CustomDialogButton({
    super.key,
    required this.text,
    required this.fontSize,
    this.textAlign = TextAlign.center, // Default text alignment is center
    this.fontWeight = FontWeight.w400, // Default fontWeight is normal
    this.letterSpacing,
    required this.onClick,
    this.isActive = true
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onClick, // Disable the onClick callback if isEnabled is false
      child: Container(
        padding: EdgeInsets.all(AppDimensions.di_1),
        height: AppDimensions.di_50,
        width: DeviceSize.getScreenWidth(context) * 0.85,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isActive ? <Color>[
              AppColors.blueGradientColor1, // Gradient Start Color
              AppColors.blueGradientColor2, // Gradient End Color
            ] : <Color>[
              AppColors.whiteColor, // Gradient Start Color
              AppColors.whiteColor, // Gradient End Color
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.di_40), // Rounded corners
          ),
          border: isActive ? null: Border.all(
            color: AppColors.blueGradientColor2, // Second border color
            width: 1,
          ),
        ),
        child: Center( // This will center the text vertically and horizontally
          child: Text(
            text,
            style: TextStyle(
              color:  isActive ? AppColors.whiteColor : AppColors.blueGradientColor1 , // Change text color when disabled
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
