import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';

class CustomLoginSignupContainer extends StatelessWidget {
  final double height;
  final double marginHeight;
  final Widget child;
  final Color backgroundColor;

  // Constructor that accepts height and child widget
  const CustomLoginSignupContainer({super.key, required this.height, required this.child, required this.marginHeight, this.backgroundColor = AppColors.textColor});

  @override
  Widget build(BuildContext context) {
    // Get screen height

    return Container(
      padding: EdgeInsets.all(AppDimensions.di_12),
      //height: height - (height * marginHeight),
      margin: EdgeInsets.only(top: height * marginHeight), // Apply 32% margin from the top
      decoration: BoxDecoration(
        color: backgroundColor, // White background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.di_25), // Rounded top-left corner
          topRight: Radius.circular(AppDimensions.di_25), // Rounded top-right corner
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.di_20), // Padding inside the container
        child: child, // This is where the passed child widget will be displayed
      ),
    );
  }
}
