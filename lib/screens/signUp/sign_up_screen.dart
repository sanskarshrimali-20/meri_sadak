import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/otpVerify/otp_screen.dart';
import 'package:meri_sadak/screens/termAndPrivacy/terms_condition_privacy_policy.dart';
import 'package:meri_sadak/viewmodels/forgotChangePassword/forgot_change_password_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';
import '../../utils/device_size.dart';
import '../../utils/network_provider.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_login_signup_textfield.dart';
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
  bool _isChecked = false;
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
  String? storage;

  final dbHelper = DatabaseHelper();

  final _storage = LocalSecureStorage(); // Secure storage instance

  @override
  void initState() {
    _loadClickedType();

    super.initState();
  }

  Future<void> _loadClickedType() async {
    storage = await _storage.getTermsPolicy();

    setState(() {
      if (storage == "checked") {
        _isChecked = true;
      } else {
        _isChecked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final networkProvider = Provider.of<NetworkProviderController>(context);

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

                  Padding(padding: EdgeInsets.only(top: AppDimensions.di_40, left: AppDimensions.di_20),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(ImageAssetsPath.backArrow, fit: BoxFit.cover),
                      ),
                    ),),

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
                    backgroundColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.authDarkModeColor,
                    marginHeight: 0.25,
                    height: DeviceSize.getScreenHeight(context),
                    // Set remaining height for the container (full height - image height)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        CustomTextWidget(
                          text: AppStrings.signUp, fontSize: AppDimensions.di_24, color: themeProvider.themeMode == ThemeMode.light
                            ? AppColors.textColor
                            : AppColors.authDarkModeTextColor, fontWeight: AppFontWeight.fontWeight600,
                        ),

                        SizedBox(height: AppDimensions.di_15),

                        // Space between widgets
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.di_16),
                          child: Column(
                            children: [
                              CustomLoginSignupTextFieldWidget(
                                textColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.textColor
                                    : AppColors.authDarkModeTextColor,
                                backgroundColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.whiteColor
                                    : AppColors.authDarkModeColor,
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
                                textColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.textColor
                                    : AppColors.authDarkModeTextColor,
                                backgroundColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.whiteColor
                                    : AppColors.authDarkModeColor,
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
                                textColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.textColor
                                    : AppColors.authDarkModeTextColor,
                                backgroundColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.whiteColor
                                    : AppColors.authDarkModeColor,
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
                                      if (_isChecked) {
                                        _storage.checkedTermsPolicy(
                                          "unChecked",
                                        );
                                      } else {
                                        _storage.checkedTermsPolicy("checked");
                                      }
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
                                        TextSpan(text: AppStrings.iAccept,  style: TextStyle(
                                          color: themeProvider.themeMode == ThemeMode.light
                                              ? AppColors.textColor
                                              : AppColors.authDarkModeTextColor,
                                        ),),
                                        TextSpan(
                                          text: AppStrings.termsCondition,
                                          style: TextStyle(
                                            color: themeProvider.themeMode == ThemeMode.light
                                                ? AppColors.textColor
                                                : AppColors.authDarkModeTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          // Highlight color for the clickable text
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap = () async {
                                                  final result = await Navigator.push(
                                                    // ignore: use_build_context_synchronously
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              const TermsConditionPrivacyPolicyScreen(),
                                                    ),
                                                  );

                                                  if (result != null) {
                                                   setState(() {
                                                     _isChecked = true;
                                                   });
                                                  }
                                                },
                                        ),
                                        TextSpan(text: AppStrings.and, style: TextStyle(
                                          color: themeProvider.themeMode == ThemeMode.light
                                              ? AppColors.textColor
                                              : AppColors.authDarkModeTextColor,
                                        ),),
                                        TextSpan(
                                          text: AppStrings.privacyPolicy,
                                          style: TextStyle(
                                            color: themeProvider.themeMode == ThemeMode.light
                                                ? AppColors.textColor
                                                : AppColors.authDarkModeTextColor,
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
                                onClick: () async {
                                  if (fullNameError == null && emailError == null && phoneError == null) {
                                    _onSignInClick(networkProvider);
                                  }
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
                                    TextSpan(
                                      text: AppStrings.alreadyHaveAccount,
                                      style: TextStyle(
                                        color: AppColors.greyTxt,
                                        fontWeight: AppFontWeight.fontWeight400,
                                        fontSize: AppDimensions.di_15,
                                      ),
                                    ),
                                    TextSpan(text: ' '),
                                    TextSpan(
                                      text: AppStrings.loginWithSpace,
                                      style: TextStyle(
                                        color: themeProvider.themeMode == ThemeMode.light
                                            ? AppColors.textColor
                                            : AppColors.authDarkModeTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppDimensions.di_15,
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

  Future<void> _onSignInClick(NetworkProviderController networkProvider) async {

    if (_isChecked == false) {
      showErrorDialog(
        context,
        "Please select Terms & Conditions and Privacy Policy",
        backgroundColor: Colors.red,
      );
      return;
    }

    if(networkProvider.status == ConnectivityStatus.online) {
      String fullName = _fullNameController.text.trim();
      String email = _emailController.text.trim();
      String phoneNo = _phoneNoController.text.trim();

      validateFullName(fullName);
      validateEmail(email);
      validatePhoneNum(phoneNo);
        // If the form is valid, proceed with the logic
        // If both username and password are valid, proceed to the next screen

        final profile = await dbHelper.getSignupDetails(
            _phoneNoController.text);
        String phoneNoExist = profile?['phoneNo'] ?? 'No Name';

        if (phoneNoExist == _phoneNoController.text) {
          showErrorDialog(
            context,
            "This account already existed!!",
            backgroundColor: Colors.red,
          );
        }
        else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpValidationScreen(type: AppStrings.signUp,
                    userSignUpDetails: {
                      'fullName': fullName,
                      'phoneNo': phoneNo,
                      'email': email
                    },), // Navigate to home screen
            ),
          );
        }
    }
    else{
      showErrorDialog(
        context,
        AppStrings.noInternet,
        backgroundColor: Colors.red,
      );
    }
  }

  validateFullName(String value) {
    setState(() {
      if (value.trim().isEmpty) {
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
      if (value.trim().isEmpty) {
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
      if (value.trim().isEmpty) {
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
