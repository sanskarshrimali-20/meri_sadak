import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final double buttonWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.fontSize =  AppDimensions.di_15,
    this.padding = const EdgeInsets.symmetric(vertical:  AppDimensions.di_12, horizontal:  AppDimensions.di_24),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.buttonWidth =  AppDimensions.di_100
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(buttonWidth, AppDimensions.di_50),
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
    );
  }
}
