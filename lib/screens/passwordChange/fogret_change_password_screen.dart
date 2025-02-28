import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_login_signup_textfield.dart';
import '../../widgets/custom_password_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  bool _isPasswordVisible = false;

  final TextEditingController _usernameController = TextEditingController();
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
                    ImageAssetsPath.forgetPasswordBg,
                    // Path to the background image
                    fit:
                        BoxFit
                            .cover, // Make sure the image covers the container
                  ),
                ),

                CustomLoginSignupContainer(
                  marginHeight: 0.40,
                  height: DeviceSize.getScreenHeight(context),
                  // Set remaining height for the container (full height - image height)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Example: Add a TextField inside the white container
                      Text(
                        AppStrings.forgotPassword,
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

                            Image.asset(
                              ImageAssetsPath.loginSignupBtBgFill,
                            ),

                            const SizedBox(height: AppDimensions.di_20),

                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_back),
                                  SizedBox(width: AppDimensions.di_2),
                                  Text(
                                    AppStrings.backToLogIn,
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: AppDimensions.di_14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            )
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
