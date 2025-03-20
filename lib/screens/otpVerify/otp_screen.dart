import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import '../../widgets/login_signup_bg_active.dart';

class OtpValidationScreen extends StatefulWidget {

  String type;

  OtpValidationScreen({super.key, required this.type});

  @override
  State<OtpValidationScreen> createState() => _OtpValidationScreen();
}

class _OtpValidationScreen extends State<OtpValidationScreen> {

  void _onOTPCompleted(String otp) {
    print("Entered OTP: $otp");
    // Do something with the OTP, such as verifying it with a backend
  }

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
                    ImageAssetsPath.loginBg, //  ImageAssetsPath.forgetPasswordBg,
                    // Path to the background image
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
                    top:  DeviceSize.getScreenHeight(context) * 0.1,
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
                      CustomTextWidget(
                        text: AppStrings.otpVerification,
                        fontSize: AppDimensions.di_22,
                        color: AppColors.black,
                        fontWeight: AppFontWeight.fontWeight600,
                      ),
                      SizedBox(height: AppDimensions.di_20), // Space between widgets

                      Container(
                        child: Column(
                          children: [
                            
                            CustomTextWidget(text: AppStrings.weHaveSend, fontSize: AppDimensions.di_16, color: AppColors.black),

                            const SizedBox(height: AppDimensions.di_30),

                            OTPInputField(onCompleted: _onOTPCompleted),

                            const SizedBox(height: AppDimensions.di_30),

                            CustomLoginSignupBgActiveWidget(
                              text: AppStrings.submit,
                              fontSize: AppDimensions.di_18,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: () {
                                final userProfile = {
                                  'fullname': "",
                                  'phoneNo':"",
                                  'email': "",};
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                        PasswordCreateScreen(type: widget.type, userProfile: userProfile,), // Pass the profile data
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
                                    text: AppStrings.didntReceiveOtp,
                                    style: TextStyle(
                                      color: AppColors.greyTxt,
                                      fontWeight: AppFontWeight.fontWeight400,
                                      fontSize: AppDimensions.di_16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppStrings.resendOtp,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // Highlight color for the clickable text
                                    recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {

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

}
