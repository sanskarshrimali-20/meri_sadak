import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import 'package:meri_sadak/utils/device_utils.dart';
import 'package:meri_sadak/viewmodels/signup/sign_up_viewmodel.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_strings.dart';
import '../../providerData/theme_provider.dart';
import '../../services/LocalStorageService/local_storage.dart';
import '../../utils/device_size.dart';
import '../../utils/network_provider.dart';
import '../../viewmodels/forgotChangePassword/forgot_change_password_viewmodel.dart';
import '../../widgets/custom_login_signup_container.dart';
import '../../widgets/custom_password_widget.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/login_signup_bg_active.dart';

class PasswordCreateScreen extends StatefulWidget {

  final String type;
  final Map<String, dynamic> userSignUpDetails;
  final String userCred;

  const PasswordCreateScreen({super.key, required this.type, this.userSignUpDetails = const {'fullName': '', 'phoneNo': '', 'email': ''},
    this.userCred = ""
  });

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

  final LocalSecureStorage _localStorage = LocalSecureStorage();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final networkProvider = Provider.of<NetworkProviderController>(context);

    return Scaffold(
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
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      height: DeviceSize.getScreenHeight(context)* 0.6,
                      ImageAssetsPath.loginBg,
                      //  ImageAssetsPath.forgetPasswordBg,
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
                    backgroundColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.authDarkModeColor,
                    marginHeight: 0.40,
                    height: DeviceSize.getScreenHeight(context),
                    // Set remaining height for the container (full height - image height)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        CustomTextWidget(
                          text: AppStrings.createPassword, fontSize: AppDimensions.di_24, color: themeProvider.themeMode == ThemeMode.light
                            ? AppColors.textColor
                            : AppColors.authDarkModeTextColor, fontWeight: AppFontWeight.fontWeight600,
                        ),

                        SizedBox(height: AppDimensions.di_20),

                        // Space between widgets
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.di_16),
                          child: Column(
                            children: [
                              customPasswordWidget(
                                textColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.textColor
                                    : AppColors.authDarkModeTextColor,
                                backgroundColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.whiteColor
                                    : AppColors.authDarkModeColor,
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
                                textColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.textColor
                                    : AppColors.authDarkModeTextColor,
                                backgroundColor: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.whiteColor
                                    : AppColors.authDarkModeColor,
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

                                    if(_passwordController.text == _passwordConfirmController.text){
                                      if (widget.type == AppStrings.resetPassword) {

                                        _handleForgetChangePassword(context, widget.userCred, networkProvider);

                                      }
                                      else if(widget.type == AppStrings.signUp){

                                        _handleSignUp(context, networkProvider);

                                      }else {
                                        _handleForgetChangePassword(context, widget.userCred, networkProvider);
                                      }
                                    }
                                    else{
                                      showErrorDialog(
                                        context,
                                        "Password and Confirm Password must be match",
                                        backgroundColor: Colors.red,
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

  validateConfirmPassword(String value) {
    setState(() {
      if (value.trim().isEmpty) {
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

  Future<void> _handleForgetChangePassword(BuildContext context, String userCred, NetworkProviderController networkProvider) async {

    if(networkProvider.status == ConnectivityStatus.online) {
      final forgotChangePasswordViewModel = Provider.of<
          ForgotChangePasswordViewModel>(context, listen: false);

      String? forgotChangePasswordOperationResultMessage = await
      forgotChangePasswordViewModel.forgotChangePassword(
          userCred, _passwordController.text);

      if (forgotChangePasswordOperationResultMessage == "Success") {
        showErrorDialog(
          context,
          "Password updated successfully",
          backgroundColor: Colors.green,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                LoginScreen(), // Pass the profile data
          ),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomTextWidget(
              text: forgotChangePasswordOperationResultMessage!,
              fontSize: AppDimensions.di_16,
              color: AppColors.whiteColor,
            ),
            backgroundColor: Colors.red,
            // Use orange or yellow for warnings
            duration: Duration(seconds: 3), // Duration the SnackBar is visible
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

  Future<void> _handleSignUp(BuildContext context,NetworkProviderController networkProvider) async {

    if(networkProvider.status == ConnectivityStatus.online){
      if(widget.userSignUpDetails.isEmpty){
        return;
      }
      else{
        widget.userSignUpDetails["password"] = _passwordController.text;
        widget.userSignUpDetails['gender'] = '';
        widget.userSignUpDetails['address'] = '';
      }




      // widget.userSignUpDetails["deviceId"] = DeviceIUtils.getId();

      final signUpViewModel = Provider.of<SignUpViewModel>(context, listen: false);

      String? signUpOperationResultMessage = await signUpViewModel.performSignUp(widget.userSignUpDetails);

/*    if (kDebugMode) {
      log("Inside login screen");
      log(loginOperationResultMessage!);
    }

    if (!loginOperationResultMessage!.toLowerCase().contains("success")) {
      ToastUtil().showToast(
        // ignore: use_build_context_synchronously
        context,
        loginOperationResultMessage,
        Icons.error_outline,
        AppColors.toastBgColorRed,
      );

      return;
    }

    ToastUtil().showToast(
      // ignore: use_build_context_synchronously
      context,
      'Successfully logged in',
      Icons.check_circle_outline,
      AppColors.toastBgColorGreen,
    );

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
          builder: (context) => const BottomNavigationHome(
            initialIndex: 0,
          )),
    );*/

      if(signUpOperationResultMessage == "Success"){

        _localStorage.checkedTermsPolicy("unChecked",);
        _localStorage.setLoginUser(widget.userSignUpDetails["phoneNo"]);

        showErrorDialog(
          context,
          "You're register successfully",
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
              text: signUpOperationResultMessage!,
              fontSize: AppDimensions.di_16,
              color: AppColors.whiteColor,
            ),
            backgroundColor: Colors.red,
            // Use orange or yellow for warnings
            duration: Duration(seconds: 3), // Duration the SnackBar is visible
          ),
        );
      }
    }
    else {
      showErrorDialog(
        context,
        AppStrings.noInternet,
        backgroundColor: Colors.red,
      );
    }
  }
}
