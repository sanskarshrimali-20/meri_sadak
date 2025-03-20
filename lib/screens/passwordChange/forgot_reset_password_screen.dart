import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import 'package:meri_sadak/screens/otpVerify/otp_screen.dart';
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

class ForgotResetPasswordScreen extends StatefulWidget {
  String type;

  ForgotResetPasswordScreen({super.key, required this.type});

  @override
  State<ForgotResetPasswordScreen> createState() =>
      _ForgotResetPasswordScreen();
}

class _ForgotResetPasswordScreen extends State<ForgotResetPasswordScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final FocusNode _usernameFocusNode =
      FocusNode(); // FocusNode for the text field
  final _formKey = GlobalKey<FormState>();
  bool isPhoneNumberField =
      true; // Track if we're showing phone number or email
  String? emailPhoneError;

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
                      // ImageAssetsPath.forgetPasswordBg,
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
                          text: widget.type,
                          fontSize: AppDimensions.di_24,
                          color: AppColors.black,
                        ),

                        SizedBox(height: AppDimensions.di_20),

                        // Space between widgets
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.di_16),
                          child: Column(
                            children: [
                              CustomLoginSignupTextFieldWidget(
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
                                /* validator: (value) {
                                  // Validator logic for phone number/email
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Phone Number / Email ID is required';
                                  }
                                  if (!_validateUsername(value)) {
                                    return "Please enter a valid phone number or email";
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
                                      color: AppColors.blackMagicColor,
                                      fontWeight: AppFontWeight.fontWeight600,
                                    ),
                                  ),
                                ),
                              ),

                              // const SizedBox(height: AppDimensions.di_20),

                              /*Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(child: Divider()),
                                  CustomTextWidget(
                                    text: ' or ',
                                    fontSize: AppDimensions.di_16,
                                    color: AppColors.black,
                                    fontWeight: AppFontWeight.fontWeight500,
                                  ),
                                  Flexible(child: Divider()),
                                ],
                              ),*/

                              // const SizedBox(height: AppDimensions.di_20),

                              /* customLoginSignupTextFieldWidget(
                                textEditController: _emailController,
                                hintText: AppStrings.email,
                                icon: ImageAssetsPath.mail,
                              ),*/
                              const SizedBox(height: AppDimensions.di_40),

                              CustomLoginSignupBgActiveWidget(
                                text: AppStrings.submit,
                                fontSize: AppDimensions.di_20,
                                fontWeight: AppFontWeight.fontWeight500,
                                color: AppColors.whiteColor,
                                textAlign: TextAlign.center,
                                onClick: _onForgotPasswordClick,
                              ),

                              const SizedBox(height: AppDimensions.di_40),

                              Visibility(
                                visible:
                                    widget.type != AppStrings.resetPassword,
                                // Hide the GestureDetector if the type is "Reset"
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_back),
                                      SizedBox(width: AppDimensions.di_2),
                                      CustomTextWidget(
                                        text: AppStrings.backToLogIn,
                                        fontSize: AppDimensions.di_15,
                                        fontWeight: AppFontWeight.fontWeight600,
                                        color: AppColors.blackMagicColor,
                                      ),
                                    ],
                                  ),
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

  void _onForgotPasswordClick() {
    validateEmailPhone(_usernameController.text);
    if (emailPhoneError == null) {
      // If the form is valid, proceed with the logic
      // If both username and password are valid, proceed to the next screen
      showErrorDialog(
        context,
        "OTP sent successfully!",
        backgroundColor: Colors.green,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => OtpValidationScreen(
                type: widget.type,
              ), // Pass the profile data
        ),
      );
    }
  }

  void validateEmailPhone(String value) {
    // Validator logic for phone number/email
    setState(() {
      if (value == null || value.trim().isEmpty) {
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
}
