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
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_widget.dart';
import '../../widgets/login_signup_bg_active.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isChecked = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  String? emailError;
  String? phoneError;
  String? fullNameError;

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
                      //  ImageAssetsPath.signupBg, // Path to the background image
                      fit:
                          BoxFit
                              .cover, // Make sure the image covers the container
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: DeviceSize.getScreenHeight(context) * 0.04,
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
                    marginHeight: 0.25,
                    height: DeviceSize.getScreenHeight(context),
                    // Set remaining height for the container (full height - image height)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextWidget(
                          text: AppStrings.signUp,
                          fontSize: AppDimensions.di_24,
                          color: AppColors.black,
                        ),

                        SizedBox(height: AppDimensions.di_15),

                        // Space between widgets
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.di_16),
                          child: Column(
                            children: [
                              CustomLoginSignupTextFieldWidget(
                                controller: _fullNameController,
                                hintText: AppStrings.fullName,
                                errorText: fullNameError,
                                icon: ImageAssetsPath.user,
                                label: '',
                                labelText: '',
                                isRequired: true,
                                onChanged: validateFullName,
                                /*  validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Full Name is required';
                                  }
                                  if (!RegExp(
                                    r'^[a-zA-Z\s]+$',
                                  ).hasMatch(value)) {
                                    return 'Enter a valid full name (letters and spaces only)';
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

                              CustomLoginSignupTextFieldWidget(
                                controller: _emailController,
                                hintText: AppStrings.email,
                                icon: ImageAssetsPath.mail,
                                keyboardType: TextInputType.emailAddress,
                                label: '',
                                labelText: '',
                                fieldTypeCheck: 'phoneEmail',
                                errorText: emailError,
                                isRequired: true,
                                onChanged: validateEmail,
                                /* validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Email is required';
                                  }
                                  String emailPattern =
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                                  RegExp emailRegExp = RegExp(emailPattern);
                                  if (!emailRegExp.hasMatch(value)) {
                                    return 'Enter a valid email address';
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

                              CustomLoginSignupTextFieldWidget(
                                controller: _phoneNoController,
                                hintText: AppStrings.phoneNoOnly,
                                icon: ImageAssetsPath.phone,
                                label: '',
                                labelText: '',
                                errorText: phoneError,
                                isRequired: true,
                                keyboardType: TextInputType.number,
                                isNumberWithPrefix: true,
                                maxLength: 10,
                                onChanged: validatePhoneNum,
                                /* validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Phone number is required';
                                  }
                                  // Regex to validate a 10-digit phone number starting with 6, 7, 8, or 9
                                  String phonePattern = r"^[6789][0-9]{9}$";
                                  RegExp phoneRegExp = RegExp(phonePattern);
                                  if (!phoneRegExp.hasMatch(value)) {
                                    return 'Enter a valid phone number (10 digits starting with 6, 7, 8, or 9)';
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
                                        fontSize: AppDimensions.di_14,
                                      ),
                                      // Default text style
                                      children: [
                                        TextSpan(text: AppStrings.iAccept),
                                        TextSpan(
                                          text: AppStrings.termsCondition,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                fontSize: AppDimensions.di_20,
                                fontWeight: AppFontWeight.fontWeight500,
                                color: AppColors.whiteColor,
                                textAlign: TextAlign.center,
                                onClick: _onSignInClick,
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
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _onSignInClick() {
    String fullName = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String phoneNo = _phoneNoController.text.trim();

    validateFullName(fullName);
    validateEmail(email);
    validatePhoneNum(phoneNo);

    if (fullNameError == null && emailError == null && phoneError == null) {
      // If the form is valid, proceed with the logic
      // If both username and password are valid, proceed to the next screen
      showErrorDialog(
        context,
        "You're register successfully",
        backgroundColor: Colors.green,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Navigate to home screen
        ),
      );
    }
  }

  validateFullName(String value) {
    setState(() {
      if (value == null || value.trim().isEmpty) {
        fullNameError = 'Full Name is required';
      } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
        fullNameError = 'Enter a valid full name (letters and spaces only)';
      } else {
        fullNameError = null;
      }
    });
  }

  validateEmail(String value) {
    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp emailRegExp = RegExp(emailPattern);
    setState(() {
      if (value == null || value.trim().isEmpty) {
        emailError = 'Email is required';
      } else if (!emailRegExp.hasMatch(value)) {
        emailError = 'Enter a valid email address';
      } else {
        emailError = null;
      }
    });
  }

  validatePhoneNum(String value) {
    // Regex to validate a 10-digit phone number starting with 6, 7, 8, or 9
    String phonePattern = r"^[6789][0-9]{9}$";
    RegExp phoneRegExp = RegExp(phonePattern);
    setState(() {
      if (value == null || value.trim().isEmpty) {
        phoneError = 'Phone number is required';
      } else if (!phoneRegExp.hasMatch(value)) {
        phoneError =
            'Enter a valid phone number (10 digits starting with 6, 7, 8, or 9)';
      } else {
        phoneError = null;
      }
    });
  }
}
