import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';

class SubmitFeedbackScreen extends StatefulWidget {
  final int stepIndex;
  final Function(int, bool, bool) isStepCompleted;
  const SubmitFeedbackScreen({super.key,required this.stepIndex,
    required this.isStepCompleted,});

  @override
  State<SubmitFeedbackScreen> createState() => _SubmitFeedbackScreen();
}

class _SubmitFeedbackScreen extends State<SubmitFeedbackScreen> {
  int? _selectedValue = 1; // Initially, 1 is selected

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppDimensions.di_20),

        Text(
          AppStrings.wouldYouLikeTo,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: AppDimensions.di_20,
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(height: AppDimensions.di_20),

        Row(
          children: [
            Text(
              AppStrings.yesIWould,
              style: TextStyle(
                fontSize: AppDimensions.di_18,
                fontWeight: AppFontWeight.fontWeight400,
              ),
            ),
            Spacer(),
            SizedBox(
              height: 30, // Adjust the height to control the space for the radio button
              child: Radio<int>(
                value: 1,
                groupValue: _selectedValue,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
                activeColor: AppColors.color_4E44E0,
              ),
            ),
          ],
        ),
        // Radio button 2
        Row(
          children: [
            Text(
              AppStrings.noIPrefer,
              style: TextStyle(
                fontSize: AppDimensions.di_18,
                fontWeight: AppFontWeight.fontWeight400,
              ),
            ),
            Spacer(),
            SizedBox(
              height: 30, // Adjust the height to control the space for the radio button
              child: Radio<int>(
                value: 2,
                groupValue: _selectedValue,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
                activeColor: AppColors.color_4E44E0,
              ),
            ),
          ],
        ),

        SizedBox(height: AppDimensions.di_20),

        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              // Aligns text to the right end
              child: TextButton(
                onPressed: () {
                  widget.isStepCompleted(
                    widget.stepIndex,
                    false, true
                  );
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
                  AppStrings.previous,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            ),

            Spacer(),

            Align(
              alignment: Alignment.centerRight,
              // Aligns text to the right end
              child: TextButton(
                onPressed: () {
                  widget.isStepCompleted(
                    widget.stepIndex,
                    false, false
                  );
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
                  AppStrings.next,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
