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
import '../../widgets/custom_snackbar.dart';
import '../../widgets/login_signup_bg_active.dart';

class PasswordCreateScreen extends StatefulWidget {
  String type;

  PasswordCreateScreen({super.key, required this.type});

  @override
  State<PasswordCreateScreen> createState() => _PasswordCreateScreen();
}

class _PasswordCreateScreen extends State<PasswordCreateScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
  TextEditingController();

  String? passwordError;
  String? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap everything in SingleChildScrollView
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image covering the top 30% of the screen
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      ImageAssetsPath.loginBg,
                      //  ImageAssetsPath.forgetPasswordBg,
                      fit:
                      BoxFit
                          .cover, // Make sure the image covers the container
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: DeviceSize.getScreenHeight(context) * 0.1,
                    ), // Space for the image
                    child: Center(
                      child: Image.asset(
                        ImageAssetsPath.splashScreenLogo,
                        width: DeviceSize.getScreenWidth(context) * 0.5,
                        height: DeviceSize.getScreenHeight(context) * 0.2,
                      ),
                    ),
                  ),

                  CustomLoginSignupContainer(
                    marginHeight: 0.40,
                    height: DeviceSize.getScreenHeight(context),
                    // Set remaining height for the container (full height - image height)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextWidget(
                          text: AppStrings.createPassword,
                          fontSize: AppDimensions.di_24,
                          color: AppColors.black,
                        ),

                        SizedBox(height: AppDimensions.di_20),

                        // Space between widgets
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.di_16),
                          child: Column(
                            children: [
                              customPasswordWidget(
                                textEditController: _passwordController,
                                hintText: AppStrings.enterNewPassword,
                                errorText: passwordError,
                                isPassword: true,
                                isPasswordVisible: _isPasswordVisible,
                                togglePasswordVisibility:
                                _togglePasswordVisibility,
                                onChanged: validatePassword,
                                /* validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "New Password is required";
                                  }
                                  if (!_validatePassword(value)) {
                                    // Show error if password is weak
                                    return "Password should be at least 8 characters long, contain an uppercase letter, a number, and a special character";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // Trigger validation on text change
                                  setState(() {
                                    _formKey.currentState?.validate();
                                  });
                                },*/
                              ),

                              const SizedBox(height: AppDimensions.di_20),

                              customPasswordWidget(
                                textEditController: _passwordConfirmController,
                                hintText: AppStrings.confirmNewPassword,
                                errorText: confirmPasswordError,
                                isPassword: true,
                                isPasswordVisible: _isConfirmPasswordVisible,
                                togglePasswordVisibility:
                                _toggleConfirmPasswordVisibility,
                                onChanged: validateConfirmPassword,
                                /*  validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Confirm New Password is required";
                                  }
                                  if (!_validatePassword(value)) {
                                    // Show error if password is weak
                                    return "Password should be at least 8 characters long, contain an uppercase letter, a number, and a special character";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // Trigger validation on text change
                                  setState(() {
                                    _formKey.currentState?.validate();
                                  });
                                },*/
                              ),

                              const SizedBox(height: AppDimensions.di_40),

                              CustomLoginSignupBgActiveWidget(
                                text: AppStrings.submit,
                                fontSize: AppDimensions.di_20,
                                fontWeight: AppFontWeight.fontWeight500,
                                color: AppColors.whiteColor,
                                textAlign: TextAlign.center,
                                onClick: () {
                                  validatePassword(_passwordController.text);
                                  validateConfirmPassword(
                                    _passwordConfirmController.text,
                                  );
                                  if (confirmPasswordError == null &&
                                      passwordError == null) {
                                    if (widget.type ==
                                        AppStrings.resetPassword) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              HomeScreen(), // Pass the profile data
                                        ),
                                      );
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              LoginScreen(), // Pass the profile data
                                        ),
                                      );
                                    }
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
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  bool _validatePassword(String password) {
    String passwordPattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"; // Strong password regex
    RegExp passwordRegExp = RegExp(passwordPattern);

    return passwordRegExp.hasMatch(
      password,
    ); // Check if password matches the strong password pattern
  }

  void validatePassword(String value) {
    setState(() {
      if (value == null || value.trim().isEmpty) {
        passwordError = "Password is required";
      } else if (!_validatePassword(value)) {
        // Show error if password is weak
        passwordError =
        "Password should be at least 8 characters long, contain an uppercase letter, a number, and a special character";
      } else {
        passwordError = null;
      }
    });
  }

  validateConfirmPassword(String value) {
    setState(() {
      if (value == null || value.trim().isEmpty) {
        confirmPasswordError = "Confirm New Password is required";
      } else if (!_validatePassword(value)) {
        // Show error if password is weak
        confirmPasswordError =
        "Password should be at least 8 characters long, contain an uppercase letter, a number, and a special character";
      } else if (_passwordController.text != value) {
        confirmPasswordError = "Password not matched";
      } else {
        confirmPasswordError = null;
      }
    });
  }
}
