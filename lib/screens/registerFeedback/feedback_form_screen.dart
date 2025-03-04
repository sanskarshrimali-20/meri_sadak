import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_field.dart';
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

            SizedBox(height: AppDimensions.di_30,),

           /* Row(
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
*/
          /*  CustomDropdownSearch(
              labelText: AppStrings.categoryOfComplaint,
              hintText: AppStrings.selectCategoryOfComplaint,
              textController: _categoryComplaintController,
              items: [],
              dropdownHeight: 300,
              isRequired: true,
            ),*/

           /* CustomDropdownSearch(
              labelText: AppStrings.state,
              hintText: AppStrings.selectState,
              textController: _stateController,
              items: [],
              dropdownHeight: 200,
              isRequired: true,
              onChanged: (value) async {},
            ),*/

            CustomDropdownField(
              hintText: AppStrings.selectState,
              textController: _stateController,
              items: [],
              dropdownHeight: AppDimensions.di_300,
              isRequired: true,
            ),

            // District dropdown
           /* CustomDropdownSearch(
              labelText: AppStrings.district,
              hintText: AppStrings.selectDistrict,
              textController: _districtController,
              items: [''], // Show a fallback empty option if districts is empty
              dropdownHeight: 200,
              isRequired: true,
            ),*/

            CustomDropdownField(
              hintText: AppStrings.selectDistrict,
              textController: _districtController,
              items: [],
              dropdownHeight: AppDimensions.di_300,
              isRequired: true,
            ),

           /* CustomDropdownSearch(
              labelText: AppStrings.block,
              hintText: AppStrings.selectBlock,
              textController: _blockController,
              items: [''], // Show a fallback empty option if districts is empty
              dropdownHeight: 200,
              isRequired: true,
            ),*/

            CustomDropdownField(
              hintText: AppStrings.selectBlock,
              textController: _blockController,
              items: [],
              dropdownHeight: AppDimensions.di_300,
              isRequired: false,
            ),


           /* CustomDropdownSearch(
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
            ),*/

            CustomDropdownField(
              hintText: AppStrings.selectCategoryOfComplaint,
              textController: _stateController,
              items: [],
              dropdownHeight: AppDimensions.di_300,
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
                    icon: Icons.arrow_forward,
                    iconColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                    backgroundColor: AppColors.color_E77728,
                    fontSize: AppDimensions.di_18,
                    padding: EdgeInsets.symmetric(
                      vertical:  AppDimensions.di_6,
                      horizontal:  AppDimensions.di_15,
                    ),
                    borderRadius: BorderRadius.circular( AppDimensions.di_100),
                  ),
                ),

                Spacer(),

                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    text: AppStrings.next,
                    onPressed: () async {
                      widget.isStepCompleted(
                        widget.stepIndex,
                        true,
                        false,
                      );
                    },
                    icon: Icons.arrow_forward,
                    iconColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                    backgroundColor: AppColors.color_E77728,
                    fontSize: AppDimensions.di_18,
                    padding: EdgeInsets.symmetric(
                      vertical:  AppDimensions.di_6,
                      horizontal:  AppDimensions.di_15,
                    ),
                    borderRadius: BorderRadius.circular( AppDimensions.di_100),
                  ),
                ),
              ],
            ),

          ],
      ),
    );
  }
}
