import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.fontSize = 15.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: padding,
      ),
      child: CustomTextWidget(
        text: text,
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
        letterSpacing: 0.0,
      ),
    );
  }
}
