import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? userProfile;

  const HomeScreen({super.key, this.userProfile});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    key: _scaffoldKey,
      backgroundColor: AppColors.greyHundred,
      appBar: MyAppBar.buildAppBar(AppStrings.appName, AppStrings.citizenFeedbackSystem, true, context, _scaffoldKey),
      drawer: Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.di_50, top: AppDimensions.di_50),  // Add space outside the drawer
        child: const CustomDrawer(),
      ),
    body: SingleChildScrollView(
    )
  );
  }

}