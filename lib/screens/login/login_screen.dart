import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/passwordChange/forgot_reset_password_screen.dart';
import 'package:meri_sadak/screens/signUp/sign_up_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_login_signup_container.dart';
import 'package:meri_sadak/widgets/custom_login_signup_textfield.dart';
import 'package:meri_sadak/widgets/login_signup_bg_unactive.dart';
import '../../widgets/custom_password_widget.dart';
import '../../widgets/login_signup_bg_active.dart';

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
      body: SingleChildScrollView(
        // Wrap everything in SingleChildScrollView
        child: Column(
          children: [
            // Image covering the top 30% of the screen
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    ImageAssetsPath.loginBg, // Path to the background image
                    fit:
                        BoxFit
                            .cover, // Make sure the image covers the container
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top:  DeviceSize.getScreenHeight(context) * 0.1,
                  ), // Space for the image
                  child: Center(
                    child: Image.asset(
                      ImageAssetsPath.splashScreenLogo,
                      width: DeviceSize.getScreenWidth(context) * 0.5,
                      height: DeviceSize.getScreenHeight(context) * 0.2,
                    ),
                  ),
                ),

                // Adjusting the container's height so it fills the remaining space
                CustomLoginSignupContainer(
                  marginHeight: 0.40,
                  height: DeviceSize.getScreenHeight(context),
                  // Set remaining height for the container (full height - image height)
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
                      SizedBox(height: AppDimensions.di_20),

                      // Space between widgets
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.di_16),
                        child: Column(
                          children: [
                            customLoginSignupTextFieldWidget(
                              textEditController: _usernameController,
                              hintText: AppStrings.phoneNo,
                              icon: ImageAssetsPath.user,
                            ),
                            const SizedBox(height: AppDimensions.di_20),

                            customPasswordWidget(
                              textEditController: _passwordController,
                              hintText: AppStrings.password,
                              isPassword: true,
                              isPasswordVisible: _isPasswordVisible,
                              togglePasswordVisibility:
                                  _togglePasswordVisibility,
                            ),

                            const SizedBox(height: AppDimensions.di_15),

                            Align(
                              alignment: Alignment.centerRight,
                              // Aligns text to the right end
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ForgotResetPasswordScreen(
                                                type: AppStrings.forgotPassword,
                                              ), // Pass the profile data
                                    ),
                                  );
                                },
                                child: Text(
                                  AppStrings.forgotPasswordQue,
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: AppDimensions.di_16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: AppDimensions.di_40),

                            CustomLoginSignupBgActiveWidget(
                              text: AppStrings.login,
                              fontSize: AppDimensions.di_20,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            HomeScreen(), // Pass the profile data
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: AppDimensions.di_20),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: AppDimensions.di_14,
                                ),
                                // Default text style
                                children: [
                                  TextSpan(text: AppStrings.dontHaveAccount,   style: TextStyle(
                                    color: AppColors.greyTxt,
                                      fontWeight: AppFontWeight.fontWeight400,
                                      fontSize: AppDimensions.di_15
                                  ),),
                                  TextSpan(text: ' '),
                                  TextSpan(
                                    text: AppStrings.signUp,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                    // Highlight color for the clickable text
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(
                                              // ignore: use_build_context_synchronously
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const SignUpScreen(),
                                              ),
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                            /* CustomLoginSignupBgUnActiveWidget(
                              text: AppStrings.signUp,
                              fontSize: AppDimensions.di_20,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.black,
                              textAlign: TextAlign.center,
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            SignUpScreen(), // Pass the profile data
                                  ),
                                );
                              },
                            ),*/
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

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}
