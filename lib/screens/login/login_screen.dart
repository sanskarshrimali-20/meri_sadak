import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/passwordChange/forgot_reset_password_screen.dart';
import 'package:meri_sadak/screens/signUp/sign_up_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_login_signup_container.dart';
import 'package:meri_sadak/widgets/custom_login_signup_textfield.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:meri_sadak/widgets/login_signup_bg_unactive.dart';
import 'package:provider/provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../viewmodels/login/login_view_model.dart';
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

  final dbHelper = DatabaseHelper();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? emailPhoneError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap everything in SingleChildScrollView
        child: Form(
          key: _formKey,

    final loginViewModel = context.watch<LoginViewModel>();

    return WillPopScope(
      onWillPop: () async {
        // When the back button is pressed, exit the app
        SystemNavigator.pop();  // Exits the app
        return false; // Return false to prevent the default back navigation
      },
      child: Scaffold(
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
                      ImageAssetsPath.loginBg, // Path to the background image
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

=======
      
                  // Adjusting the container's height so it fills the remaining space
                  CustomLoginSignupContainer(
                    marginHeight: 0.40,
                    height: DeviceSize.getScreenHeight(context),
                    // Set remaining height for the container (full height - image height)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Example: Add a TextField inside the white container
                        Text(
                          AppStrings.login,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: AppDimensions.di_24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppDimensions.di_20),

                        // Space between widgets
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.di_16),
                          child: Column(
                            children: [
                              CustomLoginSignupTextFieldWidget(
                                controller: _usernameController,
                                hintText: AppStrings.phoneNo,
                                icon: ImageAssetsPath.user,
                                keyboardType: TextInputType.emailAddress,
                                label: '',
                                fieldTypeCheck: 'phoneEmail',
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
                              const SizedBox(height: AppDimensions.di_20),

                              customPasswordWidget(
                                textEditController: _passwordController,
                                hintText: AppStrings.password,
                                errorText: passwordError,
                        CustomTextWidget(
                           text: AppStrings.login, fontSize: AppDimensions.di_22, color: AppColors.black, fontWeight: AppFontWeight.fontWeight600,
                        ),
                        SizedBox(height: AppDimensions.di_20),
      
                        // Space between widgets
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.di_14),
                          child: Column(
                            children: [

                              CustomLoginSignupTextFieldWidget(
                                textEditController: _usernameController,
                                hintText: AppStrings.phoneNo,
                                icon: ImageAssetsPath.user,
                                maxlength: 25,
                              ),
                              const SizedBox(height: AppDimensions.di_20),
      
                              customPasswordWidget(
                                textEditController: _passwordController,
                                hintText: AppStrings.password,
                                isPassword: true,
                                isPasswordVisible: _isPasswordVisible,
                                togglePasswordVisibility:
                                    _togglePasswordVisibility,
                                onChanged: validatePassword,
                                /*    validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Password is required";
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
                                  child: Text(
                                    AppStrings.forgotPasswordQue,
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: AppDimensions.di_16,
                                    ),
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
                                onClick: _onLoginClick,
                              ),

                              const SizedBox(height: AppDimensions.di_20),

                              ),
      
                              const SizedBox(height: AppDimensions.di_13),
      
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
                                                  type: AppStrings.forgotPassword,
                                                ), // Pass the profile data
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppStrings.forgotPasswordQue,
                                    style: TextStyle(
                                      color: AppColors.textColor.withAlpha(200),
                                      fontSize: AppDimensions.di_15,
                                    ),
                                  ),
                                ),
                              ),
      
                              const SizedBox(height: AppDimensions.di_40),

                              loginViewModel.isLoading
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white70,
                                ),
                              ):
                              CustomLoginSignupBgActiveWidget(
                                text: AppStrings.login,
                                fontSize: AppDimensions.di_18,
                                fontWeight: AppFontWeight.fontWeight500,
                                color: AppColors.whiteColor,
                                textAlign: TextAlign.center,
                                onClick: () {


                                  _handleLogin(context);
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

                                    fontSize: AppDimensions.di_15,
                                  ),
                                  // Default text style
                                  children: [
                                    TextSpan(text: AppStrings.dontHaveAccount,   style: TextStyle(
                                      color: AppColors.greyTxt,
                                        fontWeight: AppFontWeight.fontWeight400,
                                        fontSize: AppDimensions.di_15
                                    ),),
                                    TextSpan(text: ' '),
                                    TextSpan(
                                      text: AppStrings.signUp,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,

                                        fontWeight: AppFontWeight.fontWeight600,
                                          fontSize:  AppDimensions.di_16
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
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    final loginViewmodel = context.read<LoginViewModel>();

    String? loginOperationResultMessage = await loginViewmodel.performLogin(
        _usernameController.text.trim(), _passwordController.text.trim());

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

    if(loginOperationResultMessage == "Success"){
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
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // Function to handle login button click
  void _onLoginClick() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    validateEmailPhone(username);
    validatePassword(password);

    if (emailPhoneError == null && passwordError == null) {
      // If the form is valid, proceed with the logic
      // If both username and password are valid, proceed to the next screen
      showErrorDialog(
        context,
        "Login successfully !",
        backgroundColor: Colors.green,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Navigate to home screen
        ),
      );
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
      if (value == null || value.trim().isEmpty) {
        emailPhoneError = 'Phone Number / Email ID is required';
      } else if (!_validateUsername(value)) {
        emailPhoneError = "Please enter a valid phone number or email";
      } else {
        emailPhoneError = null;
      }
    });
  }

  void validatePassword(String value) {
    setState(() {
      if (value == null || value.trim().isEmpty) {
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
