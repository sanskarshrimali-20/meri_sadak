import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final Color backgroundColorOne;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final double buttonWidth;
  final double buttonHeight;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.blueGradientColor1,
    this.backgroundColorOne = AppColors.blueGradientColor2,
    this.fontSize = AppDimensions.di_15,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppDimensions.di_12,
      horizontal: AppDimensions.di_24,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.buttonWidth = AppDimensions.di_100,
    this.buttonHeight = AppDimensions.di_50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          colors: [backgroundColor, backgroundColorOne],
          // Define your gradient colors here
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), // Apply the gradient here
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make background transparent
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: padding,
        ),
        child: CustomTextWidget(
          text: text,
          fontSize: fontSize,
          color: textColor,
          fontWeight: AppFontWeight.fontWeight500,
          textAlign: TextAlign.center,
          letterSpacing: 0.0,
        ),
      ),
    );
  }
}
