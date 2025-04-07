import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/AppVersion/app_version.dart';
import 'package:meri_sadak/screens/PrivacyAndSecurity/privacy_and_security.dart';
import 'package:meri_sadak/screens/appearance/appearance.dart';
import 'package:meri_sadak/screens/profile/profile.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../providerData/theme_provider.dart';
import '../../utils/fontsize_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/drawer_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,
     /* appBar: CustomAppBar(
        title: AppStrings.contactUs,
        leadingIcon: ImageAssetsPath.backArrow,
      ),*/
      body: CustomBodyWithGradient(
        title: AppStrings.settings,
        childHeight: DeviceSize.getScreenHeight(context) * 0.36,
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

                  SizedBox(height: AppDimensions.di_10),

                  customDrawerWidget(
                    fontSize: fontSizeProvider.fontSize,
                    title: AppStrings.myProfile,
                    icon: ImageAssetsPath.user,
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
                          builder: (context) => ProfileScreen(),
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
                    fontSize: fontSizeProvider.fontSize,
                    title: AppStrings.appearance,
                    icon: ImageAssetsPath.appearanceIcon,
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
                          builder: (context) => AppearanceScreen(),
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
                    fontSize: fontSizeProvider.fontSize,
                    title: AppStrings.privacyAndSecurity,
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
                          builder: (context) => PrivacyAndSecurityScreen(),
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
                    fontSize: fontSizeProvider.fontSize,
                    title: AppStrings.checkVersionUpdate,
                    icon: ImageAssetsPath.replace,
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
                          builder: (context) => AppVersion(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppDimensions.di_10),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*

          CustomButton(
            text: AppStrings.resetPassword,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                      ForgotResetPasswordScreen(type: AppStrings.resetPassword), // Pass the profile data
                ),
              );            },
            textColor: AppColors.whiteColor,
            backgroundColor: AppColors.color_E77728,
            fontSize: AppDimensions.di_18,
            padding:
            EdgeInsets.symmetric(vertical: AppDimensions.di_6, horizontal: AppDimensions.di_15),
            borderRadius: BorderRadius.circular(AppDimensions.di_100),
          ),



        ]))
    );
  }


}*/
