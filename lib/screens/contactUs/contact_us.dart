import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/contact_us_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../providerData/theme_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreen();
}

class _ContactUsScreen extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title: AppStrings.contactUs,
        childHeight: 0,
        child: Wrap(
          children: [ Padding(
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
                    SizedBox(height: AppDimensions.di_15,),

                    ContactUsWidget(
                      text: AppStrings.timings,
                      textOne: "10:00 AM to 5:00 PM",
                      textTwo: "",
                      icon: ImageAssetsPath.clock,
                      fontWeight: AppFontWeight.fontWeight600,
                      color: themeProvider.themeMode == ThemeMode.light
                          ? AppColors.black
                          : AppColors.whiteColor,
                    ),

                    Divider(
                      color: Colors.grey.withAlpha(60), // Line color
                      thickness: AppDimensions.di_1, // Line thickness
                      indent: AppDimensions.di_10, // Space from the left
                      endIndent: AppDimensions.di_10, // Space from the right
                    ),

                    SizedBox(height: AppDimensions.di_15,),

                    ContactUsWidget(
                      text: AppStrings.phoneNoOnly,
                      textOne: "+91 11-26714001",
                      textTwo: "+91 11-26714002",
                      icon: ImageAssetsPath.phone,
                      space: AppDimensions.di_15,
                      fontWeight: AppFontWeight.fontWeight600,
                      color: themeProvider.themeMode == ThemeMode.light
                          ? AppColors.black
                          : AppColors.whiteColor,
                    ),
                    Divider(
                      color: Colors.grey.withAlpha(60), // Line color
                      thickness: AppDimensions.di_1, // Line thickness
                      indent: AppDimensions.di_10, // Space from the left
                      endIndent: AppDimensions.di_10, // Space from the right
                    ),
                    SizedBox(height: AppDimensions.di_15,),

                    ContactUsWidget(
                      text: AppStrings.emailId,
                      textOne: "merisadakhelp@gmail.com",
                      icon: ImageAssetsPath.mail,
                      fontWeight: AppFontWeight.fontWeight600,
                      color: themeProvider.themeMode == ThemeMode.light
                          ? AppColors.black
                          : AppColors.whiteColor,
                    ),
                    Divider(
                      color: Colors.grey.withAlpha(60), // Line color
                      thickness: AppDimensions.di_1, // Line thickness
                      indent: AppDimensions.di_10, // Space from the left
                      endIndent: AppDimensions.di_10, // Space from the right
                    ),
                    SizedBox(height: AppDimensions.di_15,),

                    ContactUsWidget(
                      text: AppStrings.address,
                      textOne: AppStrings.addressNRDDA,
                      icon: ImageAssetsPath.locationPin,
                      fontWeight: AppFontWeight.fontWeight600,
                      color: themeProvider.themeMode == ThemeMode.light
                          ? AppColors.black
                          : AppColors.whiteColor,
                      maxlines: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),]
        ),
      ),
    );
  }
}
