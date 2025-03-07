import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import 'package:meri_sadak/screens/otpVerify/otp_screen.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_login_signup_textfield.dart';
import '../../widgets/custom_password_widget.dart';
import '../../widgets/login_signup_bg_active.dart';

class PasswordCreateScreen extends StatefulWidget {

  String type;
  PasswordCreateScreen({super.key, required this.type});

  @override
  State<PasswordCreateScreen> createState() => _PasswordCreateScreen();
}

class _PasswordCreateScreen extends State<PasswordCreateScreen> {

  bool _isPasswordVisible = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

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
                    ImageAssetsPath.forgetPasswordBg,
                    fit: BoxFit.cover, // Make sure the image covers the container
                  ),
                ),

                CustomLoginSignupContainer(
                  marginHeight: 0.40,
                  height: DeviceSize.getScreenHeight(context),
                  // Set remaining height for the container (full height - image height)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      CustomTextWidget(text: AppStrings.createPassword, fontSize: AppDimensions.di_24, color: AppColors.black),

                      SizedBox(height: AppDimensions.di_20), // Space between widgets

                      Container(
                        padding: const EdgeInsets.all(AppDimensions.di_16),
                        child: Column(
                          children: [

                            customPasswordWidget(
                              textEditController: _passwordController,
                              hintText: AppStrings.enterNewPassword,
                              isPassword: true,
                              isPasswordVisible: _isPasswordVisible,
                              togglePasswordVisibility:
                              _togglePasswordVisibility,
                            ),

                            const SizedBox(height: AppDimensions.di_20),

                            customPasswordWidget(
                              textEditController: _passwordConfirmController,
                              hintText: AppStrings.confirmNewPassword,
                              isPassword: true,
                              isPasswordVisible: _isPasswordVisible,
                              togglePasswordVisibility:
                              _togglePasswordVisibility,
                            ),

                            const SizedBox(height: AppDimensions.di_40),

                            CustomLoginSignupBgActiveWidget(
                              text: AppStrings.submit,
                              fontSize: AppDimensions.di_20,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: () {
                                if(widget.type == AppStrings.resetPassword){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          HomeScreen(), // Pass the profile data
                                    ),
                                  );
                                }
                               else{
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          LoginScreen(), // Pass the profile data
                                    ),
                                  );
                                }
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
