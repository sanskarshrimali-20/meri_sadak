import 'package:flutter/material.dart';
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

class AboutMeriSadak extends StatefulWidget {
  const AboutMeriSadak({super.key});

  @override
  State<AboutMeriSadak> createState() => _AboutMeriSadakState();
}

class _AboutMeriSadakState extends State<AboutMeriSadak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      body: CustomBodyWithGradient(
        title: AppStrings.aboutMeriSadakHeading,
        childHeight: DeviceSize.getScreenHeight(context),
        child: ListView(
          children: [
            // Carousel Slider
            CustomCarouselSlider(
              imageList: [
                ImageAssetsPath.aboutMeriSadakFrame1,
                ImageAssetsPath.aboutMeriSadakFrame2,
              ],
            ),

            // Use CustomExpansionTile for "About PMGSY"
            CustomExpansionTile(
              title: AppStrings.aboutMeriSadakHeading,
              subheading: '', //AppStrings.aboutMeriSadakSubHeading,
              content: Text(
                AppStrings.aboutMeriSadakSubHeading,
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
          ],
        ),
      ),
    );
  }
}
