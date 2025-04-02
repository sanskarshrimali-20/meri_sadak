import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/allFeedback/all_feedabck_second_screen.dart';
import 'package:meri_sadak/screens/registerFeedback/register_feedback_new_screen.dart';
import 'package:meri_sadak/screens/roadList/road_list_screen.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../providerData/permission_provider.dart';
import '../../providerData/theme_provider.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? userProfile;

  const HomeScreen({super.key, this.userProfile});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 /* final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();*/

  List<Map<String, dynamic>> blockList = [];

  @override
  void initState() {
    _checkPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        // When the back button is pressed, exit the app
        SystemNavigator.pop(); // Exits the app
        return false; // Return false to prevent the default back navigation
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor:
            themeProvider.themeMode == ThemeMode.light
                ? AppColors.app_bg_color
                : AppColors.darkModeColor,
        // appBar: MyAppBar.buildAppBar(
        //   AppStrings.appName,
        //   AppStrings.citizenFeedbackSystem,
        //   true,
        //   context,
        //   _scaffoldKey,
        // ),
        drawer: Padding(
          padding: const EdgeInsets.only(
            bottom: AppDimensions.di_50,
            top: AppDimensions.di_50,
          ),
          // Add space outside the drawer
          child: CustomDrawer(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: DeviceSize.getScreenWidth(context),
                child: Stack(
                  children: [
                    Image.asset(
                      ImageAssetsPath.homeBgHeader,
                      fit: BoxFit.cover,
                      width: DeviceSize.getScreenWidth(context),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Row(children: [
                        GestureDetector(
                          onTap: (){
                            _scaffoldKey.currentState?.openDrawer();  // Correct way to open the drawer
                          },
                          child: SvgPicture.asset(
                            ImageAssetsPath.drawerIcon, color: AppColors.whiteColor, width: AppDimensions.di_20, height: AppDimensions.di_20,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){

                          },
                          child: SvgPicture.asset(
                            ImageAssetsPath.notificationIcon,
                          ),
                        ),
                      ],),
                    ),

                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: DeviceSize.getScreenHeight(context) * 0.2),
                        child: Column(
                        children: [

                            CustomTextWidget(text: AppStrings.yourFeedback, fontSize: AppDimensions.di_30, color: AppColors.whiteColor,
                              fontWeight: AppFontWeight.fontWeight700, textAlign: TextAlign.center,),

                            CustomTextWidget(text: AppStrings.togetherBuild, fontSize: AppDimensions.di_18, color: AppColors.whiteColor,
                              fontWeight: AppFontWeight.fontWeight400, textAlign: TextAlign.center,),

                        ],
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: "New Register Feedback",
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterFeedbackNewScreen(),
                      ),
                    );
                  },
                  textColor: AppColors.whiteColor,
                  backgroundColor: AppColors.color_E77728,
                  fontSize: AppDimensions.di_18,
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.di_6,
                    horizontal: AppDimensions.di_15,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.di_100),
                  buttonWidth: AppDimensions.di_300,
                ),
              ),

              SizedBox(height: 20),

              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: "All Feedback",
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllFeedbackSecondScreen(),
                      ),
                    );
                  },
                  textColor: AppColors.whiteColor,
                  backgroundColor: AppColors.color_E77728,
                  fontSize: AppDimensions.di_18,
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.di_6,
                    horizontal: AppDimensions.di_15,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.di_100),
                  buttonWidth: AppDimensions.di_300,
                ),
              ),
/*
              CustomTextWidget(
                text: blockList.length.toString(),
                fontSize: 18,
                color: AppColors.black,
              ),*/
              /* Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    text: "Old Register Feedback",
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterFeedbackScreen(),
                        ),
                      );
                    },
                    textColor: AppColors.whiteColor,
                    backgroundColor: AppColors.color_E77728,
                    fontSize: AppDimensions.di_18,
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.di_6,
                      horizontal: AppDimensions.di_15,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.di_100),
                    buttonWidth: AppDimensions.di_300,
                  ),
                ),*/

              /* GestureDetector(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterFeedbackNewScreen()),
                          );
                        },
                        textColor: AppColors.whiteColor,
                        backgroundColor: AppColors.color_E77728,
                        fontSize: AppDimensions.di_18,
                        padding:
                        EdgeInsets.symmetric(vertical: AppDimensions.di_6, horizontal: AppDimensions.di_15),
                        borderRadius: BorderRadius.circular(AppDimensions.di_100),
                      ),
                    ),

                    SizedBox(height: 20,),

                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        text: AppStrings.next,
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterFeedbackScreen()),
                          );
                        },
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
              )*/
            ],
          ),
        ),
      ),
    );
  }

  void openRoadListScreen(String label, String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoadListScreen(label: label, value: value),
      ),
    );
  }

  // Function to check permissions and show dialogs if necessary
  Future<void> _checkPermissions() async {
    final permissionProvider = Provider.of<PermissionProvider>(
      context,
      listen: false,
    );

    // Request location permission
    await permissionProvider.requestLocationPermissionNew(context);

    // Request camera permission
    await permissionProvider.requestCameraPermissionNew(context);
  }

/*  Future<void> _fetchData(BuildContext context) async {
    final xmlMasterDataViewModel = Provider.of<XmlMasterDataViewModel>(
      context,
      listen: false,
    );

    // Schedule the fetching of data after the current build phase
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      List<Map<String, dynamic>> states =
          await xmlMasterDataViewModel.getStatesFromDB();

      List<Map<String, dynamic>> districts = await xmlMasterDataViewModel
          .getDistrictsFromDB("1");

      List<Map<String, dynamic>> blocks = await xmlMasterDataViewModel
          .getBlocksFromDB("101");

      setState(() {
        blockList = blocks;
      });
    });
  }*/
}
