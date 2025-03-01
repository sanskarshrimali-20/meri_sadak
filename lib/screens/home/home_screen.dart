import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/roadList/road_list_screen.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_home_tabs.dart';
import '../registerFeedback/register_feedback_screen.dart';

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
      backgroundColor: AppColors.whiteColor,
      appBar: MyAppBar.buildAppBar(
        AppStrings.appName,
        AppStrings.citizenFeedbackSystem,
        true,
        context,
        _scaffoldKey,
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.di_50,
          top: AppDimensions.di_50,
        ),
        // Add space outside the drawer
        child: const CustomDrawer(),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                // Aligns text to the right end
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterFeedbackScreen()));
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.di_24,
                      vertical: AppDimensions.di_15,
                    ),
                    // Padding
                    backgroundColor: AppColors.color_E77728,
                    // Background color
                    textStyle: TextStyle(
                      fontSize: AppDimensions.di_18,
                    ), // Text style
                  ),
                  child: Text(
                    AppStrings.registerFeedback,
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
              ),
              CustomHomeTabs(
                label: AppStrings.sanctionedRoads,
                onTap: (label, value) async {
                  openRoadListScreen(label, value);
                },
              ),
              SizedBox(height: AppDimensions.di_15),
              CustomHomeTabs(
                label: AppStrings.completedRoads,
                onTap: (label, value) async {
                  openRoadListScreen(label, value);
                },
              ),

              SizedBox(height: AppDimensions.di_15),
              CustomHomeTabs(
                label: AppStrings.ongoingRoads,
                onTap: (label, value) async {
                  openRoadListScreen(label, value);
                },
              ),
            ],
          ),
        )
      ),
    );
  }

  void openRoadListScreen(String label, String value){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoadListScreen(label: label, value: value)),
    );
  }
}
