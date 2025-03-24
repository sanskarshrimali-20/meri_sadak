import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';
import '../../widgets/custom_body_with_gradient.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

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

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,      body: CustomBodyWithGradient(
        title: AppStrings.myProfile,
        childHeight: DeviceSize.getScreenHeight(context) * 0.6,
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

            padding: EdgeInsets.all(AppDimensions.di_18),

            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: AppDimensions.di_15),

                  Center(
                    child: Container(
                      width: 90, // Width of the circle (2 * radius)
                      height: 90, // Height of the circle (2 * radius)
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make the container a circle
                        border: Border.all(
                          color: AppColors.toastBgColorGreen, // Color of the border
                          width: 2, // Stroke width
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50, // Radius of the avatar (half of the container size)
                        backgroundColor: AppColors.whiteColor, // Background color for the circle
                        child: Text(
                          char, // First character of the name
                          style: TextStyle(
                            color: AppColors.blueGradientColor1, // Color of the text
                            fontSize: AppDimensions.di_50, // Text size
                            fontWeight: AppFontWeight.fontWeight600, // Text weight
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimensions.di_30),

                  CustomTextWidget(
                   text: '${AppStrings.name} : $name', fontSize: AppDimensions.di_18,
                    fontWeight: AppFontWeight.fontWeight500,
                    color: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_1, // Space from the left
                    endIndent: AppDimensions.di_1, // Space from the right
                  ),

                  CustomTextWidget(
                    text: '${AppStrings.phoneNoO} : ${phone}', fontSize: AppDimensions.di_18,
                    fontWeight: AppFontWeight.fontWeight500,
                    color: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_1, // Space from the left
                    endIndent: AppDimensions.di_1, // Space from the right
                  ),

                  CustomTextWidget(
                    text: '${AppStrings.emailId} : ${email}', fontSize: AppDimensions.di_18,
                    fontWeight: AppFontWeight.fontWeight500,
                    color: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_1, // Space from the left
                    endIndent: AppDimensions.di_1, // Space from the right
                  ),

                  CustomTextWidget(
                    text: '${AppStrings.address} : CDAC Pune', fontSize: AppDimensions.di_18,
                    fontWeight: AppFontWeight.fontWeight500, color: themeProvider.themeMode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _initializeUserDetails() async {

    String? user = await _localStorage.getLoginUser();
    final profile = await dbHelper.getSignupDetails(user!);

    setState(() {
      name =  profile?['fullName'] ?? 'No Name';
      phone =  profile?['phoneNo'] ?? 'No Name';
      email = profile?['email'] ?? 'No Name';
      char  = name.isNotEmpty ? name[0] : '';
    });
  }
}
