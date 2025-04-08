import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/aboutPmgsy/about_pmgsy.dart';
import 'package:meri_sadak/screens/contactUs/contact_us.dart';
import 'package:meri_sadak/screens/settings/setting_screen.dart';
import 'package:meri_sadak/services/AppVersion/app_version_service.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:meri_sadak/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providerData/theme_provider.dart';
import '../screens/AboutMeriSadak/about_meri_sadak.dart';
import '../screens/login/login_screen.dart';
import '../services/DatabaseHelper/database_helper.dart';
import '../services/LocalStorageService/local_storage.dart';
import 'custom_base_dialog.dart';

class CustomDrawer extends StatefulWidget {

  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final LocalSecureStorage _localStorage = LocalSecureStorage();
  final dbHelper = DatabaseHelper();
  String name = "";
  String phone = "";
  String email = "";
  String char = "";

  @override
  void initState() {
    _initializeUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.di_20),
        ),
      ),
      width:
          DeviceSize.getScreenWidth(context) -
          (DeviceSize.getScreenWidth(context) * 0.10),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.di_25),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.di_16),
              height: AppDimensions.di_130,
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
                  Container(
                    width: 67, // Width of the circle (2 * radius)
                    height: 67, // Height of the circle (2 * radius)
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make the container a circle
                      border: Border.all(
                        color: AppColors.toastBgColorGreen, // Color of the border
                        width: 2, // Stroke width
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40, // Radius of the avatar (half of the container size)
                      backgroundColor: AppColors.whiteColor, // Background color for the circle
                      child: Text(
                        char, // First character of the name
                        style: TextStyle(
                          color: AppColors.blueGradientColor1, // Color of the text
                          fontSize: AppDimensions.di_40, // Text size
                          fontWeight: AppFontWeight.fontWeight600, // Text weight
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: AppDimensions.di_15),
                  SizedBox(
                    width: DeviceSize.getScreenWidth(context) * 0.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimensions.di_12),
                        CustomTextWidget(
                          maxlines: 1,
                          text: name,
                          fontSize: AppDimensions.di_20,
                          color: AppColors.whiteColor,
                          fontWeight: AppFontWeight.fontWeight600,
                        ),
                        SizedBox(height: AppDimensions.di_5),
                        CustomTextWidget(
                          text: phone,
                          fontSize: AppDimensions.di_13,
                          color: AppColors.whiteColor,
                          maxlines: 1,
                        ),
                        CustomTextWidget(
                          text: email,
                          fontSize: AppDimensions.di_13,
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
                      Navigator.of(context).pop(); // Close the drawer
                    },
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.settings,
                    icon: ImageAssetsPath.appearance,
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
                          builder: (context) => SettingScreen(),
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
                    title: AppStrings.share,
                    icon: ImageAssetsPath.share,
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
                      Share.share('Check out this awesome Flutter app!');
                    },
                  ),
                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: AppStrings.contactUs,
                    icon: ImageAssetsPath.contacts,
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
                          builder: (context) => ContactUsScreen(),
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
                    title: AppStrings.about,
                    icon: ImageAssetsPath.info,
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
                        MaterialPageRoute(builder: (context) => AboutPMGSY()),
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
                    title: AppStrings.aboutMeriSadak,
                    icon: ImageAssetsPath.info,
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
                          builder: (context) => AboutMeriSadak(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Spacer(), // Push Logout to the bottom of the drawer

            Divider(
              color: Colors.grey.withAlpha(60), // Line color
              thickness: AppDimensions.di_1, // Line thickness
              indent: AppDimensions.di_10, // Space from the left
              endIndent: AppDimensions.di_10, // Space from the right
            ),

            customDrawerWidget(
              title: AppStrings.logout,
              icon: ImageAssetsPath.logout,
              onClick: () {
                _localStorage.setLoggingState("false");

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }, iconColor: Colors.red, textColor: Colors.red, visible: false, logoutVisible: false,
                versionNumber: AppVersionService().version ?? '1.0.0'
            ),
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

  Future<void> _initializeUserDetails() async {

    String? user = await _localStorage.getLoginUser();
    final profile = await dbHelper.getSignupDetails(user??"");

    setState(() {
     name =  profile?['fullName'] ?? 'No Name';
     phone =  profile?['phoneNo'] ?? 'No Name';
     email = profile?['email'] ?? 'No Name';
     char  = name.isNotEmpty ? name[0] : '';
    });
  }

}
