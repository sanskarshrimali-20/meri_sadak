import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/termAndPrivacy/terms_condition_privacy_policy.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_login_signup_textfield.dart';
import '../../widgets/custom_password_widget.dart';
import '../../widgets/custom_text_widget.dart';
import '../../widgets/login_signup_bg_active.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState()  => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen>{

  bool _isPasswordVisible = false;
  bool _isChecked = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

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
                    ImageAssetsPath.signupBg, // Path to the background image
                    fit: BoxFit.cover, // Make sure the image covers the container
                  ),
                ),

                // Adjusting the container's height so it fills the remaining space
                CustomLoginSignupContainer(
                  marginHeight: 0.25,
                  height: DeviceSize.getScreenHeight(context), // Set remaining height for the container (full height - image height)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      CustomTextWidget(text: AppStrings.signUp, fontSize: AppDimensions.di_24, color: AppColors.black),

                      SizedBox(height: AppDimensions.di_15), // Space between widgets

                      Container(
                        padding: const EdgeInsets.all( AppDimensions.di_16),
                        child: Column(
                          children: [

                            customLoginSignupTextFieldWidget(
                              textEditController: _fullNameController,
                              hintText: AppStrings.fullName,
                              icon: ImageAssetsPath.iconPerson,
                            ),
                            const SizedBox(height: AppDimensions.di_20),

                            customLoginSignupTextFieldWidget(
                              textEditController: _emailController,
                              hintText: AppStrings.email,
                              icon: ImageAssetsPath.mail,
                            ),
                            const SizedBox(height: AppDimensions.di_20),

                            customLoginSignupTextFieldWidget(
                              textEditController: _phoneNoController,
                              hintText: AppStrings.phoneNo,
                              icon: ImageAssetsPath.phone,
                            ),

                            const SizedBox(height: AppDimensions.di_20),

                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  },
                                ),

                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: AppDimensions.di_14), // Default text style
                                    children: [
                                      TextSpan(text: AppStrings.iAccept),
                                      TextSpan(
                                        text: AppStrings.termsCondition,
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Highlight color for the clickable text
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              // ignore: use_build_context_synchronously
                                              context,
                                              MaterialPageRoute(builder: (context) => const TermsConditionPrivacyPolicyScreen()),
                                            );
                                          },
                                      ),
                                      TextSpan(text: AppStrings.and),
                                      TextSpan(
                                        text: AppStrings.privacyPolicy,
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Highlight color for the clickable text
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              // ignore: use_build_context_synchronously
                                              context,
                                              MaterialPageRoute(builder: (context) => const TermsConditionPrivacyPolicyScreen()),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                            const SizedBox(height: AppDimensions.di_40),

                            CustomLoginSignupBgActiveWidget(
                              text: AppStrings.signUp,
                              fontSize: AppDimensions.di_20,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: () {
                                Navigator.push(
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
                                style: TextStyle(color: Colors.black, fontSize: AppDimensions.di_14), // Default text style
                                children: [
                                  TextSpan(text: AppStrings.alreadyHaveAccount),
                                  TextSpan(
                                    text: AppStrings.loginWithSpace,
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Highlight color for the clickable text
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                                        );
                                      },
                                  ),
                                ],
                              ),
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

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}