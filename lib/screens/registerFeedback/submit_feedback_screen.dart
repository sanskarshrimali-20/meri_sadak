import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_widget.dart';

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

        SizedBox(height: AppDimensions.di_30),

        CustomTextWidget(
          text: AppStrings.wouldYouLikeTo,
          fontSize: AppDimensions.di_18,
          color: AppColors.blackMagicColor,
          fontWeight: AppFontWeight.fontWeight500,
          textAlign: TextAlign.center,
          // textAlign: AppFontSizeWeight.textAlignCenter,
          // letterSpacing: AppFontSizeWeight.letterSpacing_0_0,
        ),

        SizedBox(height: AppDimensions.di_20),

        Row(
          children: [
            CustomTextWidget(
              text: AppStrings.yesIWould,
              fontSize: AppDimensions.di_18,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight500,
              textAlign: TextAlign.left,
            ),
            Spacer(),
            SizedBox(
              height: AppDimensions.di_30, // Adjust the height to control the space for the radio button
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
            CustomTextWidget(
              text: AppStrings.noIPrefer,
              fontSize: AppDimensions.di_18,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight500,
              textAlign: TextAlign.left,
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

        SizedBox(height: AppDimensions.di_30),

        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                text: AppStrings.back,
                onPressed: () async {
                  widget.isStepCompleted(
                    widget.stepIndex,
                    true,
                    false,
                  );
                },
                textColor: AppColors.whiteColor,
                backgroundColor: AppColors.color_E77728,
                fontSize: AppDimensions.di_18,
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.di_6,
                  horizontal: AppDimensions.di_15,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.di_100),
              ),
            ),

            Spacer(),

            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: AppStrings.submit,
                onPressed: () async {
                  widget.isStepCompleted(
                    widget.stepIndex,
                    true,
                    false,
                  );
                },
                textColor: AppColors.whiteColor,
                backgroundColor: AppColors.color_E77728,
                fontSize: AppDimensions.di_18,
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.di_6,
                  horizontal: AppDimensions.di_15,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.di_100),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
