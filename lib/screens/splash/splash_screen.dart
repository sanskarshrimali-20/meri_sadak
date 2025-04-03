import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/login/login_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import '../../constants/app_colors.dart';
import '../../services/LocalStorageService/local_storage.dart';

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

     /* final xmlMasterDataViewModel = Provider.of<XmlMasterDataViewModel>(context, listen: false);

      List<Map<String, dynamic>> states= await xmlMasterDataViewModel.getStatesFromDB();
      List<Map<String, dynamic>> districts= await xmlMasterDataViewModel.getStatesFromDB();
      List<Map<String, dynamic>> blocks= await xmlMasterDataViewModel.getBlocksFromDB("101");

      if(states.isEmpty){
        await xmlMasterDataViewModel.getStates();
        debugPrint("statesempty");
     }

      if(districts.isEmpty){
        await xmlMasterDataViewModel.getDistricts();
        debugPrint("districtssempty");
      }

      if(blocks.isEmpty){
        await xmlMasterDataViewModel.getBlocks(101);
        debugPrint("blockssempty");
      }

     */

      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Pass the profile data
        ),
      );*/

      final isLoggedIn = await _checkLoginStatus();

      // Ensure the widget is still mounted before accessing the context
      if (!mounted) return;

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(), // Pass the profile data
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(), // Pass the profile data
          ),
        );
      }
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
  }
}
