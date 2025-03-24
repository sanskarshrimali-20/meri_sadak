import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import '../constants/app_colors.dart';
import 'custom_text_widget.dart';

class CustomGestureContainer extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  const CustomGestureContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.width,
    required this.height,
    this.borderColor = const Color(0xFFBFC1C5),
    this.backgroundColor = Colors.transparent,
    this.textColor = const Color(0xFF000000),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.44, horizontal: 12.77),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Flexible(
              child: CustomTextWidget(
                text: text,
                fontSize: AppDimensions.di_14,
                color: AppColors.txtColor,
                fontWeight: AppFontWeight.fontWeight500,
                // textAlign: AppFontSizeWeight.textAlignCenter,
                // letterSpacing: AppFontSizeWeight.letterSpacing_0_0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
