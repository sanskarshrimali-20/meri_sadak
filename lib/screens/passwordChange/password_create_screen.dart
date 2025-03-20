import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import 'package:meri_sadak/screens/otpVerify/otp_screen.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_login_signup_textfield.dart';
import '../../widgets/custom_password_widget.dart';
import '../../widgets/login_signup_bg_active.dart';

class PasswordCreateScreen extends StatefulWidget {

  String type;
  Map<String, dynamic> userProfile;
  PasswordCreateScreen({super.key, required this.type, required this.userProfile});

  @override
  State<PasswordCreateScreen> createState() => _PasswordCreateScreen();
}

class _PasswordCreateScreen extends State<PasswordCreateScreen> {

  bool _isPasswordVisible = false;
  final dbHelper = DatabaseHelper();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

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
                    fit: BoxFit.cover, // Make sure the image covers the container
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

                      CustomTextWidget(
                        text: AppStrings.createPassword,
                        fontSize: AppDimensions.di_22,
                        color: AppColors.black,
                        fontWeight: AppFontWeight.fontWeight600,
                      ),

                      SizedBox(height: AppDimensions.di_20), // Space between widgets

                      Container(
                        padding: const EdgeInsets.all(AppDimensions.di_16),
                        child: Column(
                          children: [

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

                            CustomLoginSignupBgActiveWidget(
                              text: AppStrings.submit,
                              fontSize: AppDimensions.di_18,
                              fontWeight: AppFontWeight.fontWeight500,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center,
                              onClick: () {
                                if(widget.type == AppStrings.resetPassword){

                                  widget.userProfile['password'] = _passwordController.text;

                                  dbHelper.insertUserDetails(widget.userProfile);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          HomeScreen(), // Pass the profile data
                                    ),
                                  );
                                }
                                if(widget.type == AppStrings.forgotPassword){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          LoginScreen(), // Pass the profile data
                                    ),
                                  );
                                }
                               else{
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          HomeScreen(), // Pass the profile data
                                    ),
                                  );
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
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}
