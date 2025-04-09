import 'package:flutter/material.dart';
import 'package:meri_sadak/screens/registerFeedback/register_feedback_screen.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../widgets/custom_app_bar.dart';

class RoadDetailsScreen extends StatefulWidget {

  final String label, data;

  const RoadDetailsScreen({super.key, required this.label, required this.data});

  @override
  State<RoadDetailsScreen> createState() => _RoadDetailsScreen();
}

class _RoadDetailsScreen extends State<RoadDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyHundred,
      appBar: CustomAppBar(
        title: widget.label,
        leadingIcon: ImageAssetsPath.backArrow,
      ),
      body: SingleChildScrollView(
        child: Column(
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

            Align(
              alignment: Alignment.centerRight,
              // Aligns text to the right end
              child: TextButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterFeedbackScreen()));
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.di_24,
                    vertical: AppDimensions.di_15,
                  ),
                  // Padding
                  backgroundColor: AppColors.color_E77728,
                  // Background color
                  textStyle: TextStyle(
                    fontSize: AppDimensions.di_18,
                  ), // Text style
                ),
                child: Text(
                  AppStrings.registerFeedback,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
