import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double? letterSpacing;

  // Constructor to accept parameters for customization
  const CustomTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.textAlign = TextAlign.left, // Default text alignment is left
    this.fontWeight = FontWeight.w400, // Default fontWeight is normal
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:TextStyle(color: color, fontSize: fontSize, fontWeight: AppFontWeight.fontWeight500),
      textAlign: textAlign,
    );
  }
}
