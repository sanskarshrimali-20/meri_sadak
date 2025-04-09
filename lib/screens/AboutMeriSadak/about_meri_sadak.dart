import 'package:flutter/material.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../providerData/theme_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_carousel_slider.dart';
import '../../widgets/custom_expansion_tile.dart';

class AboutMeriSadak extends StatefulWidget {
  const AboutMeriSadak({super.key});

  @override
  State<AboutMeriSadak> createState() => _AboutMeriSadakState();
}

class _AboutMeriSadakState extends State<AboutMeriSadak> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        backgroundColor: themeProvider.themeMode == ThemeMode.light
        ? AppColors.bgColorGainsBoro
            : AppColors.bgDarkModeColor,
        body: CustomBodyWithGradient(
        title: AppStrings.aboutMeriSadakHeading,
        childHeight: DeviceSize.getScreenHeight(context) * 0.85,
    child: SingleChildScrollView(
    child: Column(
    children: [
    // Carousel Slider
    CustomCarouselSlider(
    imageList: [
    ImageAssetsPath.aboutMeriSadakFrame1,
    ImageAssetsPath.aboutMeriSadakFrame2,
    ],
    ),

    // Use CustomExpansionTile for "About PMGSY"
      SizedBox(height: 10,),

      CustomExpansionTile(
    backgroundColor: themeProvider.themeMode == ThemeMode.light
    ? AppColors.whiteColor
        : AppColors.boxDarkModeColor,
    textColor: themeProvider.themeMode == ThemeMode.light
    ? AppColors.black
        : AppColors.whiteColor,
    title: AppStrings.aboutMeriSadakHeading,
    subheading: '', //AppStrings.aboutMeriSadakSubHeading,
    content: Text(
    AppStrings.aboutMeriSadakSubHeading,
    textAlign: TextAlign.justify,
    style: TextStyle(
    color: themeProvider.themeMode == ThemeMode.light
    ? AppColors.black
        : AppColors.whiteColor,
    fontSize: AppDimensions.di_14,
    fontWeight: AppFontWeight.fontWeight400,
    ),
    ),
    // Container(), // Content can be empty or add custom widgets here
    initiallyExpanded: true,
    ),
    ],
    )),
    ),
    );
  }
}
