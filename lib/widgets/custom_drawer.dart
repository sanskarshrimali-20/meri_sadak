import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/aboutPmgsy/about_pmgsy.dart';
import 'package:meri_sadak/screens/contactUs/contact_us.dart';
import 'package:meri_sadak/screens/settings/setting_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:meri_sadak/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../screens/AboutMeriSadak/about_meri_sadak.dart';
import '../screens/AppVersion/app_version.dart';
import '../screens/PrivacyAndSecurity/privacy_and_security.dart';
import '../screens/login/login_screen.dart';
import '../utils/localization_provider.dart';
import 'custom_base_dialog.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return Drawer(
      width:
          DeviceSize.getScreenWidth(context) -
          (DeviceSize.getScreenWidth(context) * 0.10),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.di_25),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.di_16),
              height: AppDimensions.di_150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    AppColors.blueGradientColor1, // Gradient Start Color
                    AppColors.blueGradientColor2, // Gradient End Color
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.di_20),
                ),
              ),

              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.di_8),
                    // Optional rounded corners
                    child: Image.asset(
                      ImageAssetsPath.placeHolder,
                      width: AppDimensions.di_80,
                      height: AppDimensions.di_80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: AppDimensions.di_10),
                  SizedBox(
                    width: DeviceSize.getScreenWidth(context) * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimensions.di_20),
                        CustomTextWidget(
                          maxlines: 1,
                          text:
                              localizationProvider.localizedStrings['name'] ??
                              'Sanskar Shrimali',
                          fontSize: AppDimensions.di_20,
                          color: AppColors.whiteColor,
                        ),
                        SizedBox(height: AppDimensions.di_5),
                        CustomTextWidget(
                          text: 'Phone No: 9087654321',
                          fontSize: AppDimensions.di_14,
                          color: AppColors.whiteColor,
                          maxlines: 1,
                        ),
                        CustomTextWidget(
                          text: 'Email ID: sanskars@cdac.in',
                          fontSize: AppDimensions.di_14,
                          color: AppColors.whiteColor,
                          maxlines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimensions.di_25),

            SingleChildScrollView(
              child: Column(
                children: [
                  customDrawerWidget(
                    title: AppStrings.home,
                    icon: ImageAssetsPath.home,
                    onClick: () {
                      Navigator.of(context).pop(); // Close the drawer
                    },
                  ),

                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),
                  customDrawerWidget(
                    title: AppStrings.appearance,
                    icon: ImageAssetsPath.appearance,
                    onClick: () {
                      Navigator.of(context).pop(); // Close the drawer
                    },
                  ),
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),
                  customDrawerWidget(
                    title: AppStrings.privacyAndSecurity,
                    icon: ImageAssetsPath.beneficiaries,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyAndSecurity(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.share,
                    icon: ImageAssetsPath.share,
                    onClick: () {
                      Share.share('Check out this awesome Flutter app!');
                    },
                  ),
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.contactUs,
                    icon: ImageAssetsPath.contacts,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUsScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.about,
                    icon: ImageAssetsPath.info,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPMGSY()),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.aboutMeriSadak,
                    icon: ImageAssetsPath.info,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutMeriSadak(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.appVersion,
                    icon: ImageAssetsPath.appVersion,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppVersion(),
                        ),
                      );
                    },
                  ),

                  Divider(
                    color: Colors.grey, // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.settings,
                    icon: ImageAssetsPath.setting,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Spacer(), // Push Logout to the bottom of the drawer
            // Logout Button
            ListTile(
              leading: SvgPicture.asset(
                ImageAssetsPath.logout,
                color: Colors.red,
              ),
              title: Text(
                AppStrings.logout,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.di_18,
                ),
              ),

              onTap: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),

            /* ListTile(
              leading: Icon(Icons.refresh_outlined, color: Colors.blue),
              title: Text('Master Data'), */
            /*CustomTextWidget(
                text: 'Master Data',
                fontWeight: FontWeight.bold,
                color: Colors
                    .blue, // This will now correctly set the text color to red,
              ),*/
            /*
              onTap: () {
                */
            /*final masterDataViewModel = context.read<MasterDataViewModel>();
                masterDataViewModel
                    .fetchMasterData(refreshDB: true)
                    .then((value) {
                  if (kDebugMode) {
                    log("Fetch master data status $value");
                  }
                }).catchError((error) {
                  if (kDebugMode) {
                    log("error while fetching master data");
                    debugPrint(error);
                  }
                });*/
            /*
              },
            ),

            ListTile(
              leading: Icon(Icons.upload_file_outlined, color: Colors.blue,),
              title:Text('Upload Log File'), */
            /*CustomTextWidget(
                text: 'Upload Log File',
                fontWeight: FontWeight.bold,
                color: Colors
                    .blue, // This will now correctly set the text color to red,
              ),*/
            /*
              onTap: () {

              },
            )*/
          ],
        ),
      ),
    );
  }

  void showBaseDialog() {
    showCustomBaseDialog(
      context: context,
      title: AppStrings.welcome,
      content: AppStrings.meriSadakApplication,
      icon: ImageAssetsPath.dialogIcon,
      iconVisibility: true,
      onYesPressed: () async {},
    );
  }
}
