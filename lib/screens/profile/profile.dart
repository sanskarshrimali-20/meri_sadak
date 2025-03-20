import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../utils/localization_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_text_icon_button.dart';
import '../../widgets/drawer_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      body: CustomBodyWithGradient(
        title: AppStrings.myProfile,
        childHeight: DeviceSize.getScreenHeight(context) * 0.6,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.di_5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.di_20), // Rounded corners
              ),
            ),

            padding: EdgeInsets.all(AppDimensions.di_18),

            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: AppDimensions.di_15),

                  Center(
                    child: CircleAvatar(
                      radius: 50, // Size of the circle
                      backgroundColor: Colors.lightGreenAccent, // Background color for the circle
                      child: Text(
                        "S", // First character of the name
                        style: TextStyle(
                          color: Colors.white, // Color of the text
                          fontSize: 50, // Text size
                          fontWeight: FontWeight.bold, // Text weight
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimensions.di_40),

                  CustomTextWidget(
                   text: '${AppStrings.name} : Sanskar Shrimali', fontSize: AppDimensions.di_18, color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_1, // Space from the left
                    endIndent: AppDimensions.di_1, // Space from the right
                  ),

                  CustomTextWidget(
                    text: '${AppStrings.phoneNoO} : 9087654321', fontSize: AppDimensions.di_18, color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_1, // Space from the left
                    endIndent: AppDimensions.di_1, // Space from the right
                  ),

                  CustomTextWidget(
                    text: '${AppStrings.emailId} : sanskars@cdac.in', fontSize: AppDimensions.di_18, color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_1, // Space from the left
                    endIndent: AppDimensions.di_1, // Space from the right
                  ),

                  CustomTextWidget(
                    text: '${AppStrings.address} : CDAC Pune', fontSize: AppDimensions.di_18, color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLanguageSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Language'),
          actions: [
            Consumer<LocalizationProvider>(
              builder: (context, provider, child) {
                return Row(
                  children: [
                    CustomTextIconButton(
                      icon: Icons.language,
                      label: 'English',
                      onPressed: () {
                        provider.setLocale(Locale('en', 'US'));
                        Navigator.pop(context); // Close the dialog
                      },
                      backgroundColor: Colors.blue[50],
                      textColor: Colors.blue,
                      iconColor: Colors.blue,
                    ),
                    Spacer(),
                    CustomTextIconButton(
                      icon: Icons.temple_hindu,
                      label: 'Hindi',
                      onPressed: () {
                        provider.setLocale(Locale('hi', 'IN'));
                        Navigator.pop(context); // Close the dialog
                      },
                      backgroundColor: Colors.blue[50],
                      textColor: Colors.blue,
                      iconColor: Colors.blue,
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

}
