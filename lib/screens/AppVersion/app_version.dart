import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../providerData/permission_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_carousel_slider.dart';
import '../../widgets/custom_expansion_tile.dart';
import '../../widgets/custom_text_widget.dart';
import '../location/location_widget.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      body: CustomBodyWithGradient(
        title: AppStrings.appVersion,
        childHeight: DeviceSize.getScreenHeight(context),
        child: ListView(
          children: [
            // Use CustomExpansionTile for "About PMGSY"
            CustomExpansionTile(
              title: 'Version 6.2.4', //AppStrings.aboutPMGSYHeading,
              subheading: '', //AppStrings.aboutMeriSadakSubHeading,
              content: Text(
                AppStrings.appVersionDesc,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AppColors.blackMagicColor,
                  fontSize: AppDimensions.di_14,
                  fontWeight: AppFontWeight.fontWeight400,
                ),
              ),
              // Container(), // Content can be empty or add custom widgets here
              initiallyExpanded: true,
            ),

            /*   CustomExpansionTile(
              title: AppStrings.appVersionUpdate,
              subheading: '',
              //AppStrings.aboutMeriSadakSubHeading,
              content: Container(),
              // Content can be empty or add custom widgets here
              initiallyExpanded: false,
            ),*/
            Card(
              elevation: 2.0,
              child: Container(
                height: 50,
                padding: EdgeInsets.only(left: AppDimensions.di_10, right: AppDimensions.di_10, top: AppDimensions.di_5, bottom: AppDimensions.di_5),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidget(
                   text:   AppStrings.appVersionUpdate,
                      fontSize: AppDimensions.di_16,
                      color: AppColors.blackMagicColor,
                      fontWeight: AppFontWeight.fontWeight600,
                      // textAlign: AppFontSizeWeight.textAlignJustify,
                      // letterSpacing: AppFontSizeWeight.letterSpacing_0_5,
                    ),
                    SvgPicture.asset(ImageAssetsPath.replace,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
