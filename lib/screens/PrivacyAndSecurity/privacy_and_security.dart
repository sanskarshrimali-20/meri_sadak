import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/legalPolicy/legal_policy_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/drawer_widget.dart';
import '../passwordChange/forgot_reset_password_screen.dart';

class PrivacyAndSecurityScreen extends StatefulWidget {
  const PrivacyAndSecurityScreen({super.key});

  @override
  State<PrivacyAndSecurityScreen> createState() => _PrivacyAndSecurityScreen();
}

class _PrivacyAndSecurityScreen extends State<PrivacyAndSecurityScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      body: CustomBodyWithGradient(
        title: AppStrings.privacyAndSecurity,
        childHeight: DeviceSize.getScreenHeight(context) * 0.3,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.di_5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
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
                    title: AppStrings.clearCacheData,
                    icon: ImageAssetsPath.clear,
                    onClick: () {

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
