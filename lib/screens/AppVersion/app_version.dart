import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../providerData/theme_provider.dart';
import '../../services/AppVersion/app_version_service.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_expansion_tile.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_widget.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title: AppStrings.appVersion,
        childHeight: DeviceSize.getScreenHeight(context),
        child: ListView(
          children: [
            // Use CustomExpansionTile for "About PMGSY"
            CustomExpansionTile(
              title: "Version ${AppVersionService().version ?? '1.0.0'}", //AppStrings.aboutPMGSYHeading,
              subheading: '', //AppStrings.aboutMeriSadakSubHeading,
              textColor: themeProvider.themeMode == ThemeMode.light
                  ? AppColors.black
                  : AppColors.whiteColor,
              content: Text(
                AppStrings.appVersionDesc,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color:  themeProvider.themeMode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.whiteColor,
                  fontSize: AppDimensions.di_14,
                  fontWeight: AppFontWeight.fontWeight400,
                ),
              ),
              // Container(), // Content can be empty or add custom widgets here
              initiallyExpanded: true,
              backgroundColor: themeProvider.themeMode == ThemeMode.light
                  ? AppColors.whiteColor
                  : AppColors.boxDarkModeColor,
            ),

            Card(
              elevation: 2.0,
              child: Container(
                height: 50,
                padding: EdgeInsets.only(left: AppDimensions.di_10, right: AppDimensions.di_10, top: AppDimensions.di_5, bottom: AppDimensions.di_5),
                decoration: BoxDecoration(
                  color: themeProvider.themeMode == ThemeMode.light
                      ? AppColors.whiteColor
                      : AppColors.boxDarkModeColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    showErrorDialog(
                      context,
                      "You are in latest version",
                      backgroundColor: Colors.green,
                    );
                  },
                  child: Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                     text:   AppStrings.appVersionUpdate,
                        fontSize: AppDimensions.di_16,
                        color:  themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                        fontWeight: AppFontWeight.fontWeight600,
                        // textAlign: AppFontSizeWeight.textAlignJustify,
                        // letterSpacing: AppFontSizeWeight.letterSpacing_0_5,
                      ),
                      SvgPicture.asset(ImageAssetsPath.replace, color:  themeProvider.themeMode == ThemeMode.light
                          ? AppColors.black
                          : AppColors.whiteColor,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
