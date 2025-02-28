import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import '../constants/app_colors.dart';

class CustomBodyWithGradient extends StatelessWidget {
  final Widget child; // Content to be displayed below the gradient

  const CustomBodyWithGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
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
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.di_8),
            child: child, // Here we render the passed child widget
          ),
        ),
      ],
    );
  }
}
