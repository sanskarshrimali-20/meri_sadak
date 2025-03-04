import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/aboutPmgsy/about_pmgsy.dart';
import 'package:meri_sadak/screens/roadList/road_list_screen.dart';
import 'package:meri_sadak/widgets/custom_dropdown_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
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
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.app_bg_color,
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
        child: Container(
          padding: EdgeInsets.all(AppDimensions.di_16),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPMGSY()));
                },
                child:Image.asset(
                  ImageAssetsPath.pmgsyIg, // Path to your image in the assets folder
                  fit: BoxFit.cover, // The image will cover the entire container
                ) ,
              ),
              SizedBox(height: AppDimensions.di_20,),
              Container(
                padding: EdgeInsets.all(AppDimensions.di_16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.di_20), // Rounded corners
                  ),
                ),
                child: Column(
                  children: [

                    CustomDropdownField(
                      hintText: AppStrings.selectState,
                      textController: _stateController,
                      items: [],
                      dropdownHeight: AppDimensions.di_300,
                      isRequired: false,
                    ),

                    CustomDropdownField(
                      hintText: AppStrings.selectDistrict,
                      textController: _districtController,
                      items: [],
                      dropdownHeight: AppDimensions.di_300,
                      isRequired: false,
                    ),

                    CustomDropdownField(
                      hintText: AppStrings.selectBlock,
                      textController: _blockController,
                      items: [],
                      dropdownHeight: AppDimensions.di_300,
                      isRequired: false,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        text: AppStrings.submit,
                        onPressed: () async {

                        },
                        icon: Icons.arrow_forward,
                        iconColor: AppColors.whiteColor,
                        textColor: AppColors.whiteColor,
                        backgroundColor: AppColors.color_E77728,
                        fontSize: AppDimensions.di_18,
                        padding:
                        EdgeInsets.symmetric(vertical: AppDimensions.di_6, horizontal: AppDimensions.di_15),
                        borderRadius: BorderRadius.circular(AppDimensions.di_100),
                      ),
                    ),

                    SizedBox(height: AppDimensions.di_20,),

                    CustomHomeTabs(
                      label: AppStrings.sanctionedRoads,
                      onTap: (label, value) async {
                        openRoadListScreen(label, value);
                      },
                      image: ImageAssetsPath.sanctionIg,
                    ),
                    SizedBox(height: AppDimensions.di_15),
                    CustomHomeTabs(
                      label: AppStrings.completedRoads,
                      onTap: (label, value) async {
                        openRoadListScreen(label, value);
                      },
                      image: ImageAssetsPath.completedIg,
                    ),

                    SizedBox(height: AppDimensions.di_15),
                    CustomHomeTabs(
                      label: AppStrings.ongoingRoads,
                      onTap: (label, value) async {
                        openRoadListScreen(label, value);
                      },
                      image: ImageAssetsPath.ongoingIg,
                    ),
                  ],
                ),
              )

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
