import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/otpVerify/otp_input_field.dart';
import 'package:meri_sadak/screens/passwordChange/password_create_screen.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/login_signup_bg_active.dart';

class OtpValidationScreen extends StatefulWidget {
  String type;

  OtpValidationScreen({super.key, required this.type});

  @override
  State<OtpValidationScreen> createState() => _OtpValidationScreen();
}

class _OtpValidationScreen extends State<OtpValidationScreen> {
  String otp = "";

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
                    //  ImageAssetsPath.forgetPasswordBg,
                    // Path to the background image
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
                      // Example: Add a TextField inside the white container
                      Text(
                        AppStrings.otpValidation,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: AppDimensions.di_24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.di_20),

                      // Space between widgets
                      Container(
                        child: Column(
                          children: [
                            CustomTextWidget(
                              text: AppStrings.weHaveSend,
                              fontSize: AppDimensions.di_16,
                              color: AppColors.black,
                            ),

                            const SizedBox(height: AppDimensions.di_20),

                            OTPInputField(onCompleted: onOtpCompleted),

                            const SizedBox(height: AppDimensions.di_20),

                            CustomLoginSignupBgActiveWidget(
                              text: AppStrings.continues,
                              fontSize: AppDimensions.di_20,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: onContinuePressed,
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
                                  TextSpan(text: AppStrings.didntReceiveOtp),
                                  TextSpan(
                                    text: AppStrings.resendOtp,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // Highlight color for the clickable text
                                    recognizer:
                                        TapGestureRecognizer()..onTap = () {},
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

  // Function to handle OTP completion
  void onOtpCompleted(String otp) {
    setState(() {
      this.otp = otp;
    });
  }

  // Function to validate OTP and navigate
  void onContinuePressed() {
    print("otp.length---${otp.length}");
    if (otp.length != 6) {
      // Show an error message if OTP is incomplete
      showErrorDialog(
        context,
        "Please enter the complete OTP",
        backgroundColor: Colors.red,
      );
    } else {
      // If OTP is valid, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => PasswordCreateScreen(
                type: widget.type,
              ), // Pass the profile data
        ),
      );
    }
  }
}
