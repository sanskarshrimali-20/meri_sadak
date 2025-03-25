import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/utils/device_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../services/LocalStorageService/local_storage.dart';
import '../../viewmodels/login/login_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final LocalSecureStorage _localStorage = LocalSecureStorage();

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );


    // Start the animation
    _controller.forward().then((_) async {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Pass the profile data
        ),
      );

      /*final isLoggedIn = await _checkLoginStatus();

        if(isLoggedIn){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(), // Pass the profile data
            ),
          );
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(), // Pass the profile data
            ),
          );
        }*/
      // Check login status
    });
  }

  Future<bool> _checkLoginStatus() async {
    String? loggedInValue =
    await _localStorage.getLoggingState(); // Read from secure storage
    return loggedInValue == 'true'; // Convert string to boolean
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.blueGradientColor1, // Gradient Start Color
              AppColors.blueGradientColor2, // Gradient End Color
            ], // Gradient colors
          ),
        ),
        child: Center(
          child: Image.asset(
            ImageAssetsPath.splashScreenLogo,
            width: DeviceSize.getScreenWidth(context) * 0.5,
            height: DeviceSize.getScreenHeight(context) * 0.2,
          ),
        ),
      ),
    );
    /* return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              ImageAssetsPath.splashScreen, // Background image path
              fit: BoxFit.cover, // Make sure the background image covers the screen
            ),
          ),
        ],
      ),
    );*/
  }
}
