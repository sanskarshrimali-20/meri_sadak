import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import '../constants/app_colors.dart';

class CustomBodyWithGradient extends StatelessWidget {
  final Widget child; // Content to be displayed below the gradient
  final double childHeight; // Custom height for the child

  const CustomBodyWithGradient({
    super.key,
    required this.child,
    required this.childHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned Gradient Background
        Positioned(
          width: MediaQuery.sizeOf(context).width,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  AppColors.blueGradientColor1, // Gradient Start Color
                  AppColors.blueGradientColor2  // Gradient End Color
                ],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(AppDimensions.di_20), // Rounded corners
              ),
            ),
            height: 100, // Fixed height for gradient background
          ),
        ),
        // Content of the screen (received as the child widget)
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.di_16),
            child: SizedBox(
              height: childHeight, // Custom height for the child
              child: child, // Here we render the passed child widget
            ),
          ),
        ),
      ],
    );
  }
}
