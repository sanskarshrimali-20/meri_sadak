import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';

class RoadDetailsScreen extends StatefulWidget {
  const RoadDetailsScreen({super.key});

  @override
  State<RoadDetailsScreen> createState() => _RoadDetailsScreen();
}

class _RoadDetailsScreen extends State<RoadDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppDimensions.di_20),

        Text(
          AppStrings.pMGSYRoad,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: AppDimensions.di_20,
            fontWeight: FontWeight.w400,
          ),
        ),


      ],
    );
  }
}
