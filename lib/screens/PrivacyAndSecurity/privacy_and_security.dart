import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/legalPolicy/legal_policy_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../providerData/theme_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/selection_dialog.dart';
import '../passwordChange/forgot_reset_password_screen.dart';

class PrivacyAndSecurityScreen extends StatefulWidget {
  const PrivacyAndSecurityScreen({super.key});

  @override
  State<PrivacyAndSecurityScreen> createState() => _PrivacyAndSecurityScreen();
}

class _PrivacyAndSecurityScreen extends State<PrivacyAndSecurityScreen> {

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title: AppStrings.privacyAndSecurity,
        childHeight: DeviceSize.getScreenHeight(context) * 0.3,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.di_5),
          child: Container(
            decoration: BoxDecoration(
              color: themeProvider.themeMode == ThemeMode.light
                  ? AppColors.whiteColor
                  : AppColors.boxDarkModeColor,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.di_20), // Rounded corners
              ),
            ),

            padding: EdgeInsets.all(AppDimensions.di_15),

            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(height: AppDimensions.di_15),

                  customDrawerWidget(
                    textColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    iconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    suffixIconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    title: AppStrings.resetPassword,
                    icon: ImageAssetsPath.passLock,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                              ForgotResetPasswordScreen(type: AppStrings.resetPassword), // Pass the profile data
                        ),
                      );
                    },
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    textColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    iconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    suffixIconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    title: AppStrings.clearCacheData,
                    icon: ImageAssetsPath.clear,
                    onClick: () {
                      showCustomSelectionDialog(
                        title: "Select Language",
                        titleVisibility: false,
                        content: AppStrings.freeUpSpace,
                        icon: "assets/icons/language_icon.svg",
                        iconVisibility: false,
                        buttonLabels: [ AppStrings.continues, AppStrings.skipForNow],
                        onButtonPressed: [
                              () {
                                Navigator.pop(context);
                              },
                              () {
                            Navigator.pop(context);
                          }
                        ], isButtonActive: [true, false], context: context,
                      );
                    },
                  ),
                 /* Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.managePermissions,
                    icon: ImageAssetsPath.contacts,
                    onClick: () {
                    },
                  ),*/

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.legalAndPolicies,
                    icon: ImageAssetsPath.privacy,
                    textColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    iconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    suffixIconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                              LegalPolicyScreen(), // Pass the profile data
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
