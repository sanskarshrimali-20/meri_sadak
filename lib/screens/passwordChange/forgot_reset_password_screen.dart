import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import 'package:meri_sadak/screens/otpVerify/otp_screen.dart';
import 'package:meri_sadak/screens/passwordChange/password_create_screen.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_login_signup_textfield.dart';
import '../../widgets/custom_password_widget.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();

  bool changesuffixiocn = false;
  bool suffixiconvisible = false;
  bool continueEnable = false;

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
                    // ImageAssetsPath.forgetPasswordBg,
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
                        fontSize: AppDimensions.di_22,
                        color: AppColors.black,
                        fontWeight: AppFontWeight.fontWeight600,
                      ),

                      SizedBox(height: AppDimensions.di_20),

                      // Space between widgets
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.di_12),
                        child: Column(
                          spacing: 20,
                          children: [
                            CustomLoginSignupTextFieldWidget(
                              textEditController: _phoneNoController,
                              hintText: AppStrings.phoneEmail,
                              icon: ImageAssetsPath.user,
                              showSuffixIcon: suffixiconvisible,
                              changeSuffixIcon: changesuffixiocn,
                              maxlength: 25,
                              onChanged:
                                  (text) => {
                                setState(() {
                                  if (_phoneNoController.text.isEmpty)
                                  {
                                    suffixiconvisible = false;
                                  changesuffixiocn = false;
                                  continueEnable = false;
                                  }
                                  else{
                                    continueEnable = false;
                                  }
                                })
                                  },
                            ),


                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomButton(
                                text: AppStrings.verify,
                                onPressed: () async {
                                  setState(() {
                                    if(_phoneNoController.text.isEmpty){
                                      suffixiconvisible = false;
                                      changesuffixiocn = false;
                                      continueEnable = false;
                                    }
                                    else if(_phoneNoController.text.length > 6){
                                      suffixiconvisible = true;
                                      changesuffixiocn = true;
                                      continueEnable = true;
                                    }
                                    else{
                                      suffixiconvisible = true;
                                      changesuffixiocn = false;
                                      continueEnable = false;
                                    }
                                  });
                                },
                                textColor: AppColors.whiteColor,
                                fontSize: AppDimensions.di_18,
                                padding: EdgeInsets.symmetric(
                                  vertical: AppDimensions.di_6,
                                  horizontal: AppDimensions.di_15,
                                ),
                                borderRadius: BorderRadius.circular(AppDimensions.di_100),
                                buttonHeight: AppDimensions.di_35,
                                buttonWidth: AppDimensions.di_80,
                                backgroundColor: AppColors.toastBgColorGreen,
                                backgroundColorOne: AppColors.toastBgColorGreen,
                              ),
                            ),

                            const SizedBox(height: AppDimensions.di_30),

                            CustomLoginSignupBgActiveWidget(
                              text: AppStrings.continues,
                              fontSize: AppDimensions.di_18,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: () {

                               /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => OtpValidationScreen(
                                          type: widget.type,
                                        ), // Pass the profile data

                                  ),
                                );*/
                                final userProfile = {
                                  'fullname': "",
                                  'phoneNo':"",
                                  'email': "",};
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PasswordCreateScreen(
                                      type: widget.type, userProfile: userProfile,
                                    ), // Pass the profile data

                                  ),
                                );
                              },
                              isEnabled: continueEnable,
                            ),

                            Visibility(
                              visible: widget.type != AppStrings.resetPassword,
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
                                      fontSize: AppDimensions.di_18,
                                      color: AppColors.black,
                                      fontWeight: AppFontWeight.fontWeight500,
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
    );
  }
}
