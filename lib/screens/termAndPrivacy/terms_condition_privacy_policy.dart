import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:meri_sadak/widgets/login_signup_bg_active.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../providerData/theme_provider.dart';
import '../../services/LocalStorageService/local_storage.dart';

class TermsConditionPrivacyPolicyScreen extends StatefulWidget {
  const TermsConditionPrivacyPolicyScreen({super.key});

  @override
  State<TermsConditionPrivacyPolicyScreen> createState() =>
      _TermsConditionPrivacyPolicyScreen();
}

class _TermsConditionPrivacyPolicyScreen
    extends State<TermsConditionPrivacyPolicyScreen> {
  final List<String> items = [
    "Usage: By using this government app, you agree to its terms.",
    "Eligibility: For citizens/residents of India only.",
    "User Responsibilities: Provide accurate information; keep credentials secure.",
    "Security: Unauthorized access, hacking, or misuse is prohibited.",
    "Data Collection: Personal and non-personal data may be collected for service improvement and security.",
    "Data Sharing: Shared only with government agencies; no third-party sales.",
    "User Rights: Request data access, correction, or deletion.",
    "Service Availability: May change or be suspended without notice.",
    "Liability: Government of India is not responsible for damages from app use.",
    "Legal Compliance: Governed by the laws of India.",
  ];

  final _storage = LocalSecureStorage(); // Secure storage instance

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SizedBox.expand(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: DeviceSize.getScreenHeight(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.blueGradientColor1,
                      AppColors.blueGradientColor2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Container(
                height: DeviceSize.getScreenHeight(context),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.di_20), // Rounded corners
                  ),
                ),

                padding: EdgeInsets.only(
                  top: AppDimensions.di_40,
                  right: AppDimensions.di_30,
                  bottom: AppDimensions.di_40,
                  left: AppDimensions.di_30,
                ),

                child: Container(
                  alignment: Alignment.center,
                  // Align the child container to the center
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.boxDarkModeColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.di_20), // Rounded corners
                    ),
                  ),

                  padding: EdgeInsets.all(AppDimensions.di_15),

                  child: Column(
                    children: [
                      SizedBox(height: AppDimensions.di_15),

                      CustomTextWidget(
                        text: AppStrings.termsAndPrivacy,
                        fontSize: AppDimensions.di_24,
                        color: themeProvider.themeMode == ThemeMode.light
                            ? AppColors.textColor
                            : AppColors.authDarkModeTextColor,
                        fontWeight: AppFontWeight.fontWeight600,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: DeviceSize.getScreenHeight(context) * 0.58,
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "• ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: themeProvider.themeMode == ThemeMode.light
                                        ? AppColors.textColor
                                        : AppColors.authDarkModeTextColor,
                                  ),
                                ),
                                // Bullet point
                                Expanded(
                                  child: Text(
                                    items[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.textColor
                                          : AppColors.authDarkModeTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      Spacer(),

                      CustomLoginSignupBgActiveWidget(
                        text: AppStrings.iAccept,
                        fontSize: AppDimensions.di_18,
                        color: AppColors.whiteColor,
                        onClick: () {
                          _storage.checkedTermsPolicy("checked");
                          Navigator.pop(context, "checked");
                        },
                      ),

                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
