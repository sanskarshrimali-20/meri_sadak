import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/passwordChange/fogret_change_password_screen.dart';
import 'package:meri_sadak/screens/signUp/sign_up_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_login_signup_container.dart';
import 'package:meri_sadak/widgets/custom_login_signup_textfield.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../widgets/custom_password_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView( // Wrap everything in SingleChildScrollView

        child: Column(
          children: [
            // Image covering the top 30% of the screen
            Stack(
              children: [

                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    ImageAssetsPath.loginBg, // Path to the background image
                    fit: BoxFit.cover, // Make sure the image covers the container
                  ),
                ),

                // Adjusting the container's height so it fills the remaining space
                CustomLoginSignupContainer(
                  marginHeight: 0.40,
                  height: DeviceSize.getScreenHeight(context), // Set remaining height for the container (full height - image height)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Example: Add a TextField inside the white container
                      Text(
                        AppStrings.login,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: AppDimensions.di_24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.di_20), // Space between widgets

                      Container(
                        padding: const EdgeInsets.all(AppDimensions.di_16),
                        child: Column(
                          children: [
                            customLoginSignupTextFieldWidget(
                              textEditController: _usernameController,
                              hintText: AppStrings.phoneNo,
                              icon: ImageAssetsPath.phone,
                            ),
                            const SizedBox(height: AppDimensions.di_20),

                            customPasswordWidget(
                              textEditController: _passwordController,
                              hintText: AppStrings.password,
                              isPassword: true,
                              isPasswordVisible: _isPasswordVisible,
                              togglePasswordVisibility: _togglePasswordVisibility,
                            ),
                            const SizedBox(height: AppDimensions.di_15),

                            Align(
                              alignment: Alignment.centerRight, // Aligns text to the right end
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(), // Pass the profile data
                                  ),);
                                },
                                child: Text(
                                  AppStrings.forgotPasswordQue,
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: AppDimensions.di_16,
                                  ),
                                ),
                              )
                            ),

                            const SizedBox(height: AppDimensions.di_40),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,  MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(), // Pass the profile data
                                ),);
                              },
                              child: Image.asset(ImageAssetsPath.loginSignupBtBgFill), // Your image path here
                            ),

                            const SizedBox(height: AppDimensions.di_20),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,  MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpScreen(), // Pass the profile data
                                ),);
                              },
                              child: Image.asset(ImageAssetsPath.loginSignupBtBg),// Your image path here
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveLocalizationData() async {
    final dbHelper = DatabaseHelper();

    // English localization data
    Map<String, String> enLocalization = {
      "settings": "Settings",
      "name": "Sanskar",
      "general_settings": "General Settings",
      // other English translations
    };

    // Hindi localization data
    Map<String, String> hiLocalization = {
      "settings": "सेटिंग्स",
      "name": "संस्कार",
      "general_settings": "सामान्य सेटिंग्स",
      // other Hindi translations
    };

    // Save English and Hindi data
    await dbHelper.insertLocalization('en', enLocalization);
    await dbHelper.insertLocalization('hi', hiLocalization);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}
