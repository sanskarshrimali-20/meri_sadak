import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/otpVerify/otp_screen.dart';
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
import '../passwordChange/password_create_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isChecked = true;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

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
                    ImageAssetsPath.loginBg,
                    //  ImageAssetsPath.signupBg, // Path to the background image
                    fit:
                        BoxFit
                            .cover, // Make sure the image covers the container
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 20),
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                      ImageAssetsPath.backArrow,
                      //  ImageAssetsPath.signupBg, // Path to the background image
                      fit:
                      BoxFit
                          .cover, // Make sure the image covers the container
                    ),
                  ),
                ),),

                Container(
                  margin: EdgeInsets.only(
                    top: DeviceSize.getScreenHeight(context) * 0.06,
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
                  marginHeight: 0.3,
                  height: DeviceSize.getScreenHeight(context),
                  // Set remaining height for the container (full height - image height)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextWidget(
                        text: AppStrings.signUp,
                        fontSize: AppDimensions.di_22,
                        color: AppColors.black, fontWeight: AppFontWeight.fontWeight600,
                      ),

                      SizedBox(height: AppDimensions.di_15),

                      // Space between widgets
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.di_14),
                        child: Column(
                          children: [
                            CustomLoginSignupTextFieldWidget(
                              textEditController: _fullNameController,
                              hintText: AppStrings.fullName,
                              icon: ImageAssetsPath.user,
                            ),
                            const SizedBox(height: AppDimensions.di_15),

                            CustomLoginSignupTextFieldWidget(
                              textEditController: _emailController,
                              hintText: AppStrings.email,
                              icon: ImageAssetsPath.mail,
                            ),
                            const SizedBox(height: AppDimensions.di_15),

                            CustomLoginSignupTextFieldWidget(
                              textEditController: _phoneNoController,
                              hintText: AppStrings.phoneNoOnly,
                              icon: ImageAssetsPath.phone,
                            ),

                            const SizedBox(height: AppDimensions.di_15),

                            Row(
                              children: [
                                Checkbox(
                                  checkColor: AppColors.whiteColor,
                                  activeColor: AppColors.blueGradientColor1,
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  },
                                ),

                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AppDimensions.di_15,
                                    ),
                                    // Default text style
                                    children: [
                                      TextSpan(text: AppStrings.iAccept),
                                      TextSpan(
                                        text: AppStrings.termsCondition,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppDimensions.di_15,
                                        ),
                                        // Highlight color for the clickable text
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const TermsConditionPrivacyPolicyScreen(),
                                                  ),
                                                );
                                              },
                                      ),
                                      TextSpan(text: AppStrings.and),
                                      TextSpan(
                                        text: AppStrings.privacyPolicy,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppDimensions.di_15,
                                        ),
                                        // Highlight color for the clickable text
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const TermsConditionPrivacyPolicyScreen(),
                                                  ),
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
                              fontSize: AppDimensions.di_18,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: () {

                               /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                        OtpValidationScreen(type: AppStrings.createPassword,), // Pass the profile data
                                  ),
                                );*/

                                final userProfile = {
                                  'fullname': _fullNameController.text,
                                  'phoneNo': _phoneNoController.text,
                                  'email': _emailController.text,};

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            PasswordCreateScreen(type: AppStrings.createPassword, userProfile: userProfile), // Pass the profile data
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: AppDimensions.di_20),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: AppDimensions.di_15,
                                ),
                                // Default text style
                                children: [
                                  TextSpan(
                                    text: AppStrings.alreadyHaveAccount,
                                    style: TextStyle(
                                      color: AppColors.greyTxt,
                                      fontWeight: AppFontWeight.fontWeight400,
                                      fontSize: AppDimensions.di_15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppStrings.loginWithSpace,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimensions.di_16,
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
                                                        const LoginScreen(),
                                              ),
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
