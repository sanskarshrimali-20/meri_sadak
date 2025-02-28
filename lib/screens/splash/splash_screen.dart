import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState()  => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;

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
      // Check login status
      Navigator.push(context,  MaterialPageRoute(
        builder: (context) =>
            LoginScreen(), // Pass the profile data
      ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}