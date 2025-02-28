import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../widgets/custom_spinner.dart';
import '../../widgets/custom_text_field.dart';

class FeedbackFormScreen extends StatefulWidget {
  final int stepIndex;
  final Function(int, bool, bool) isStepCompleted;
  const FeedbackFormScreen({
    super.key,
    required this.stepIndex,
    required this.isStepCompleted,
  });

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreen();
}

class _FeedbackFormScreen extends State<FeedbackFormScreen> {
  int? _selectedValue = 1; // Initially, 1 is selected
  final TextEditingController _categoryComplaintController =
      TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _habitationController = TextEditingController();
  final TextEditingController _writeFeedbackController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: AppDimensions.di_20,),

            Row(
              children: [
                Text(
                  AppStrings.pMGSYRoad,
                  style: TextStyle(
                    fontSize: AppDimensions.di_18,
                    fontWeight: AppFontWeight.fontWeight500,
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

            Row(
              children: [
                Text(
                  AppStrings.nonPMGSYRoad,
                  style: TextStyle(
                    fontSize: AppDimensions.di_18,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: AppDimensions.di_30, // Adjust the height to control the space for the radio button
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

            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: AppDimensions.di_17,
                ), // Prefix icon
                SizedBox(
                  width: AppDimensions.di_8,
                ), // Space between the icon and text
                Text(
                  AppStrings.howToIdentifyPMGSYRoads,
                  style: TextStyle(fontSize: AppDimensions.di_14),
                ),
              ],
            ),

            SizedBox(height: AppDimensions.di_18),

            CustomDropdownSearch(
              labelText: AppStrings.categoryOfComplaint,
              hintText: AppStrings.selectCategoryOfComplaint,
              textController: _categoryComplaintController,
              items: [],
              dropdownHeight: 300,
              isRequired: true,
            ),

            CustomDropdownSearch(
              labelText: AppStrings.state,
              hintText: AppStrings.selectState,
              textController: _stateController,
              items: [],
              dropdownHeight: 200,
              isRequired: true,
              onChanged: (value) async {},
            ),

            // District dropdown
            CustomDropdownSearch(
              labelText: AppStrings.district,
              hintText: AppStrings.selectDistrict,
              textController: _districtController,
              items: [''], // Show a fallback empty option if districts is empty
              dropdownHeight: 200,
              isRequired: true,
            ),

            CustomDropdownSearch(
              labelText: AppStrings.block,
              hintText: AppStrings.selectBlock,
              textController: _blockController,
              items: [''], // Show a fallback empty option if districts is empty
              dropdownHeight: 200,
              isRequired: true,
            ),

            CustomDropdownSearch(
              labelText: AppStrings.village,
              hintText: AppStrings.selectVillage,
              textController: _villageController,
              items: [''], // Show a fallback empty option if districts is empty
              dropdownHeight: 200,
              isRequired: true,
            ),

            CustomDropdownSearch(
              labelText: AppStrings.habitation,
              hintText: AppStrings.selectHabitation,
              textController: _habitationController,
              items: [''], // Show a fallback empty option if districts is empty
              dropdownHeight: 200,
              isRequired: true,
            ),

            CustomTextField(
              labelText: AppStrings.feedback,
              label: AppStrings.writeYourFeedback,
              controller: _writeFeedbackController,
              keyboardType: TextInputType.name,
              maxLines: 4,
              maxLength: 200,
              validator: null,
              isRequired: false,
            ),

            Align(
              alignment: Alignment.centerRight,
              // Aligns text to the right end
              child: TextButton(
                onPressed: () {
                  widget.isStepCompleted(widget.stepIndex, true, false);
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
      ),
    );
  }
}
