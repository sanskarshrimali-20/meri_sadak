import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_image_path.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text_widget.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreen();
}

class _ContactUsScreen extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyHundred,
      appBar: CustomAppBar(
        title: AppStrings.contactUs,
        leadingIcon: ImageAssetsPath.backArrow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextWidget(
              text: AppStrings.addressNRDDA,
              fontSize: AppDimensions.di_16,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight500,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: AppDimensions.di_20),
            CustomTextWidget(
              text: AppStrings.contactNumberOne,
              fontSize: AppDimensions.di_16,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight500,
              textAlign: TextAlign.left,
            ),
            CustomTextWidget(
              text: AppStrings.contactNumberTwo,
              fontSize: AppDimensions.di_16,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight500,
            ),
            SizedBox(height: AppDimensions.di_20),
            CustomTextWidget(
              text: AppStrings.emailId,
              fontSize: AppDimensions.di_16,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight500,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: AppDimensions.di_20),
            CustomTextWidget(
              text: AppStrings.timings,
              fontSize: AppDimensions.di_16,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight500,
            ),
          ],
        ),
      ),
    );
  }
}
