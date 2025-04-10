import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/passwordChange/forgot_reset_password_screen.dart';
import 'package:meri_sadak/screens/signUp/sign_up_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/utils/network_provider.dart';
import 'package:meri_sadak/viewmodels/login/login_view_model.dart';
import 'package:meri_sadak/widgets/custom_login_signup_container.dart';
import 'package:meri_sadak/widgets/custom_login_signup_textfield.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../providerData/theme_provider.dart';
import '../../services/LocalStorageService/local_storage.dart';
import '../../widgets/custom_password_widget.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/login_signup_bg_active.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController(/*text: "9876543201"*/);
  final TextEditingController _passwordController = TextEditingController(/*text: "Sanssdjj12@dkl"*/);
  final LocalSecureStorage _localStorage = LocalSecureStorage();

  final FocusNode _usernameFocusNode = FocusNode();
  // FocusNode for the text field
  String? emailPhoneError;
  String? passwordError;
  bool isPhoneNumberField =
      true; // Track if we're showing phone number or email

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final networkProvider = Provider.of<NetworkProviderController>(context);

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          exit(0);
          },
    child: Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.whiteColor
          : AppColors.authDarkModeColor,
      body: SingleChildScrollView(
        // Wrap everything in SingleChildScrollView
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image covering the top 30% of the screen
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: DeviceSize.getScreenHeight(context) * 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blueGradientColor1,
                          AppColors.blueGradientColor2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
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

                  // Adjusting the container's height so it fills the remaining space
                  CustomLoginSignupContainer(
                    backgroundColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.authDarkModeColor,
                    marginHeight: 0.40,
                    height: DeviceSize.getScreenHeight(context),
                    // Set remaining height for the container (full height - image height)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Example: Add a TextField inside the white container
                        CustomTextWidget(
                         text: AppStrings.login, fontSize: AppDimensions.di_24, color: themeProvider.themeMode == ThemeMode.light
                            ? AppColors.textColor
                            : AppColors.authDarkModeTextColor, fontWeight: AppFontWeight.fontWeight600,
                        ),

                        SizedBox(height: AppDimensions.di_20),

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
                                controller: _usernameController,
                                focusNode: _usernameFocusNode,
                                hintText:
                                    isPhoneNumberField
                                        ? AppStrings.phoneNoTxt
                                        : AppStrings.emailIdTxt,
                                icon:
                                    isPhoneNumberField
                                        ? ImageAssetsPath.phone
                                        : ImageAssetsPath.mail,
                                // ImageAssetsPath.user,//
                                keyboardType:
                                    isPhoneNumberField
                                        ? TextInputType.phone
                                        : TextInputType.emailAddress,
                                label: '',
                                // fieldTypeCheck: 'phoneEmail',
                                maxLength: isPhoneNumberField ? 10 : 50,
                                labelText: '',
                                errorText: emailPhoneError,
                                isRequired: true,
                                onChanged: validateEmailPhone,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Close the keyboard when tapping outside the input field
                                  FocusScope.of(context).unfocus();
                                  // Toggle the field type
                                  setState(() {
                                    isPhoneNumberField =
                                        !isPhoneNumberField; // Toggle field type
                                    emailPhoneError =
                                        null; // Reset error text when switching fields
                                    _usernameController.clear();
                                  });
                                  // Open the keyboard again for the next focused field
                                  Future.delayed(
                                    Duration(milliseconds: 300),
                                    () {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(_usernameFocusNode);
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppDimensions.di_8,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomTextWidget(
                                      text:
                                          isPhoneNumberField
                                              ? AppStrings.useEmailInstead
                                              : AppStrings.usePhoneNumbInstead,
                                      fontSize: AppDimensions.di_15,
                                      color: themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.textColor
                                          : AppColors.authDarkModeTextColor,
                                      fontWeight: AppFontWeight.fontWeight600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppDimensions.di_20),

                              customPasswordWidget(
                                textColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.textColor
                                    : AppColors.authDarkModeTextColor,
                                backgroundColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.whiteColor
                                    : AppColors.authDarkModeColor,
                                textEditController: _passwordController,
                                hintText: AppStrings.password,
                                errorText: passwordError,
                                isPassword: true,
                                isPasswordVisible: _isPasswordVisible,
                                togglePasswordVisibility:
                                    _togglePasswordVisibility,
                                onChanged: validatePassword,
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
                                                  type:
                                                      AppStrings.forgotPassword,
                                                ), // Pass the profile data
                                      ),
                                    );
                                  },
                                  child: CustomTextWidget(
                                    text: AppStrings.forgotPasswordQue,
                                    fontSize: AppDimensions.di_15,
                                    color: themeProvider.themeMode == ThemeMode.light
                                        ? AppColors.textColor
                                        : AppColors.authDarkModeTextColor,
                                    fontWeight: AppFontWeight.fontWeight600,
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
                                onClick: () async {

                                  if(emailPhoneError == null && passwordError == null){
                                    _onLoginClick(networkProvider);
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
                                      text: AppStrings.dontHaveAccount,
                                      style: TextStyle(
                                        color: AppColors.greyTxt,
                                        fontWeight: AppFontWeight.fontWeight400,
                                        fontSize: AppDimensions.di_15,
                                      ),
                                    ),
                                    TextSpan(text: ' '),
                                    TextSpan(
                                      text: AppStrings.signUp,
                                      style: TextStyle(
                                        color: themeProvider.themeMode == ThemeMode.light
                                            ? AppColors.textColor
                                            : AppColors.authDarkModeTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
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
      ),
    ));
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // Function to handle login button click
  Future<void> _onLoginClick(NetworkProviderController networkProvider) async {

    if(networkProvider.status == ConnectivityStatus.online){
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      validateEmailPhone(username);
      validatePassword(password);

      if (emailPhoneError == null && passwordError == null) {
        // If the form is valid, proceed with the logic
        // If both username and password are valid, proceed to the next screen

        final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

        String? loginOperationResultMessage = await loginViewModel.performLogin(_usernameController.text, _passwordController.text);
        if(loginOperationResultMessage == "Success"){

          _localStorage.setLoginUser(_usernameController.text);
          showErrorDialog(
            context,
            "Login successfully !",
            backgroundColor: Colors.green,
          );
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomTextWidget(
                text: "Username/password Invalid",
                fontSize: AppDimensions.di_16,
                color: AppColors.whiteColor,
              ),
              backgroundColor: Colors.red,
              // Use orange or yellow for warnings
              duration: Duration(seconds: 3), // Duration the SnackBar is visible
            ),
          );
        }

      } else {
        // Handle invalid form (if needed)
        /*if(username.isEmpty){
        _showErrorDialog(
          context,
          "Enter Phone Number / Email ID",
          backgroundColor: Colors.red,
        );
      }else if(password.isEmpty){
        _showErrorDialog(
          context,
          "Enter Password",
          backgroundColor: Colors.red,
        );
      }else{
        _showErrorDialog(
          context,
          "Invalid login attempt. Login Fail!",
          backgroundColor: Colors.red,
        );
      }*/
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

  // Function to validate the username (Phone or Email)

  bool _validateUsername(String username) {
    // Regex for email validation
    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp emailRegExp = RegExp(emailPattern);

    // Regex for validating phone number (starts with 6,7,8,9 followed by 9 digits)
    String phonePattern = r"^[6789][0-9]{9}$";
    RegExp phoneRegExp = RegExp(phonePattern);

    // Check if the username matches the email or phone regex pattern
    if (emailRegExp.hasMatch(username)) {
      return true; // Valid email
    } else if (phoneRegExp.hasMatch(username)) {
      return true; // Valid phone number
    }
    return false; // Invalid input
  }

  // Function to validate the password
  bool _validatePassword(String password) {
    String passwordPattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"; // Strong password regex
    RegExp passwordRegExp = RegExp(passwordPattern);

    return passwordRegExp.hasMatch(
      password,
    ); // Check if password matches the strong password pattern
  }

  void validateEmailPhone(String value) {
    // Validator logic for phone number/email
    setState(() {
      if (value.trim().isEmpty) {
        emailPhoneError =
            isPhoneNumberField
                ? 'Phone Number is required'
                : 'Email ID is required';
      } else if (!_validateUsername(value)) {
        emailPhoneError =
            isPhoneNumberField
                ? "Please enter a valid phone number"
                : "Please enter a valid email id";
      } else {
        emailPhoneError = null;
      }
    });
  }

  void validatePassword(String value) {
    setState(() {
      if (value.trim().isEmpty) {
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
}
