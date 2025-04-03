import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/otpVerify/otp_input_field.dart';
import 'package:meri_sadak/screens/passwordChange/password_create_screen.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../providerData/theme_provider.dart';
import '../../utils/device_size.dart';
import '../../utils/network_provider.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/login_signup_bg_active.dart';

class OtpValidationScreen extends StatefulWidget {

  final String type;
  final Map<String, dynamic> userSignUpDetails;
  final String userCred;

  const OtpValidationScreen({
    super.key,
    required this.type,
    this.userSignUpDetails = const {
      'fullName': '',
      'phoneNo': '',
      'email': '',
    }, // Default map
    this.userCred = "",
  });

  @override
  State<OtpValidationScreen> createState() => _OtpValidationScreen();
}

class _OtpValidationScreen extends State<OtpValidationScreen> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    final networkProvider = Provider.of<NetworkProviderController>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    String phoneNo = widget.userSignUpDetails['phoneNo'];
    String email = widget.userSignUpDetails['email'];
    String maskedPhone = maskPhoneNumber(phoneNo);
    String maskedEmail = maskEmail(email);
    String maskedUserCred = maskPhoneOrEmail(widget.userCred.toString());
    String message =
        widget.type.toString() == 'Forgot Password'
            ? "OTP sent to $maskedUserCred"
            : "OTP sent to your phone $maskedPhone and email $maskedEmail";

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
                    height: DeviceSize.getScreenHeight(context)* 0.6,
                    ImageAssetsPath.loginBg,
                    //  ImageAssetsPath.forgetPasswordBg,
                    // Path to the background image
                    fit:
                        BoxFit
                            .cover, // Make sure the image covers the container
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: AppDimensions.di_40,
                    left: AppDimensions.di_20,
                  ),
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        ImageAssetsPath.backArrow,
                        fit: BoxFit.cover,
                      ),
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

                CustomLoginSignupContainer(
                  backgroundColor:
                      themeProvider.themeMode == ThemeMode.light
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
                        text: AppStrings.otpVerification,
                        fontSize: AppDimensions.di_24,
                        color:
                            themeProvider.themeMode == ThemeMode.light
                                ? AppColors.textColor
                                : AppColors.authDarkModeTextColor,
                        fontWeight: AppFontWeight.fontWeight600,
                      ),

                      SizedBox(height: AppDimensions.di_20),

                      // Space between widgets
                      Column(
                        children: [
                          CustomTextWidget(
                            text: message, //AppStrings.weHaveSend,
                            fontSize: AppDimensions.di_16,
                            color:
                                themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.textColor
                                    : AppColors.authDarkModeTextColor,
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
                            onClick: () async {
                              _onContinuePressed(networkProvider);
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
                                  text: AppStrings.didntReceiveOtp,
                                  style: TextStyle(
                                    color:
                                        themeProvider.themeMode ==
                                                ThemeMode.light
                                            ? AppColors.textColor
                                            : AppColors.authDarkModeTextColor,
                                  ),
                                ),
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: AppStrings.resendOtp,
                                  style: TextStyle(
                                    color:
                                        themeProvider.themeMode ==
                                                ThemeMode.light
                                            ? AppColors.textColor
                                            : AppColors.authDarkModeTextColor,
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
  void _onContinuePressed(NetworkProviderController networkProvider) {

    if(networkProvider.status == ConnectivityStatus.online) {
      if (otp.length != 6) {
        // Show an error message if OTP is incomplete
        showErrorDialog(
          context,
          "Please enter the complete OTP",
          backgroundColor: Colors.red,
        );
      } else if (otp == "123456") {
        // If OTP is valid, navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                PasswordCreateScreen(
                  type: widget.type,
                  userSignUpDetails: widget.userSignUpDetails,
                  userCred: widget.userCred,
                ), // Pass the profile data
          ),
        );
      } else {
        showErrorDialog(
          context,
          "Please enter the correct OTP",
          backgroundColor: Colors.red,
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

  // Mask phone number
  String maskPhoneNumber(String phoneNo) {
    if (phoneNo.length >= 10) {
      return '*******${phoneNo.substring(7)}';
    }
    return phoneNo;
  }

  // Mask email
  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length == 2) {
      String name = parts[0];
      String domain = parts[1];
      if (name.length > 2) {
        return '${name.substring(0, 2)}****@$domain';
      }
    }
    return email;
  }

  String maskPhoneOrEmail(String phoneOrEmail) {
    // Check if it's a phone number (simple check for numeric and length)
    if (phoneOrEmail.contains('@')) {
      // It's an email, apply masking
      final parts = phoneOrEmail.split('@');
      String name = parts[0];
      String domain = parts[1];

      // Mask the email by showing first two characters of the name and domain
      if (name.length > 2) {
        return '${name.substring(0, 2)}****@$domain';
      }
      return phoneOrEmail; // If the name is shorter than 2 chars, return as is
    } else {
      // It's a phone number, apply masking
      if (phoneOrEmail.length >= 10) {
        return '*******${phoneOrEmail.substring(7)}';
      }
      return phoneOrEmail; // Return as is if it's less than 10 chars
    }
  }
}
