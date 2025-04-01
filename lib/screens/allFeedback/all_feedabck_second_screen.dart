import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/AppVersion/app_version.dart';
import 'package:meri_sadak/screens/PrivacyAndSecurity/privacy_and_security.dart';
import 'package:meri_sadak/screens/appearance/appearance.dart';
import 'package:meri_sadak/screens/profile/profile.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../utils/fontsize_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_expansion_tile.dart';
import '../../widgets/drawer_widget.dart';
import 'feedback_details_screen.dart';

class AllFeedbackSecondScreen extends StatefulWidget {
  const AllFeedbackSecondScreen({super.key});

  @override
  State<AllFeedbackSecondScreen> createState() => _AllFeedbackSecondScreen();
}

class _AllFeedbackSecondScreen extends State<AllFeedbackSecondScreen> with SingleTickerProviderStateMixin {

  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> feedbackList = []; // List to hold feedback data
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchAllFeedback(); // Fetch feedback data when the widget is initialized
  }

  Future<void> fetchAllFeedback() async {
    final feedbacks =
    await dbHelper
        .getAllFeedbacks(); // Assuming you have this method in your provider
    setState(() {
      feedbackList = feedbacks; // Update the state with fetched feedback
    });
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title: AppStrings.feedbackStatus,
        childHeight: DeviceSize.getScreenHeight(context) * 0.85,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.di_5),
          child: Container(
            decoration: BoxDecoration(
              color: themeProvider.themeMode == ThemeMode.light
                  ? AppColors.whiteColor
                  : AppColors.boxDarkModeColor,
              borderRadius: BorderRadius.all(
              Radius.circular(AppDimensions.di_20), // Rounded corners
            ),
            ),
            padding: EdgeInsets.all(AppDimensions.di_15),
            child: SizedBox(
              child: Column(
                children: [

                  SizedBox(height: AppDimensions.di_15),

                  Container(
                    width: DeviceSize.getScreenWidth(context) * 0.75,
                    decoration: BoxDecoration(
                      color: AppColors.bgColorGainsBoro, // Or any other background color you like
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab, // This ensures the indicator covers the full width of the tab
                      dividerColor: AppColors.whiteColor,
                      controller: _tabController,
                      indicator: BoxDecoration(
                        gradient: LinearGradient(colors:  <Color>[
                          AppColors.blueGradientColor1, // Gradient Start Color
                          AppColors.blueGradientColor2, // Gradient End Color
                        ],),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(AppStrings.submitted),
                        ),
                        Tab(
                          child: Text(AppStrings.saved),
                        ),
                      ],
                    ),
                  ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    ListView.builder(
                              itemCount: feedbackList.length,
                              itemBuilder: (context, index) {
                                final feedback = feedbackList[index];
                                print("Feedback isFinalSubmit: ${feedback['isFinalSubmit']}");
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => FeedbackDetailsScreen(id: feedback['id']),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                             children: [
                                               CustomTextWidget(text: "Feedback ID: ${feedback['id']}", fontSize: AppDimensions.di_16, color: AppColors.black,
                                                 fontWeight: AppFontWeight.fontWeight600,),
                                               SizedBox(width: 10,),
                                               Container(
                                                 decoration: BoxDecoration(
                                                   gradient: LinearGradient(
                                                     begin: Alignment.topCenter,
                                                     end: Alignment.bottomCenter,
                                                     colors: <Color>[
                                                       AppColors.blueGradientColor1, // Gradient Start Color
                                                       AppColors.blueGradientColor2, // Gradient End Color
                                                     ]
                                                   ),
                                                   borderRadius: BorderRadius.all(
                                                     Radius.circular(AppDimensions.di_40), // Rounded corners
                                                   ),
                                                 ),
                                                 width: 80,
                                                 height: 23,
                                                 child: Center(
                                                   child: Text("submitted", style: TextStyle(color: AppColors.whiteColor),),
                                                 ),
                                               ),
                                               Spacer(),
                                               SvgPicture.asset(ImageAssetsPath.rightArrow)
                                             ],
                                           ),

                                          SizedBox(height: 10,),
                                          Divider(
                                            color: Colors.grey.withAlpha(60), // Line color
                                            thickness: AppDimensions.di_1, // Line thickness
                                            indent: AppDimensions.di_1, // Space from the left
                                            endIndent: AppDimensions.di_11, // Space from the right
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                    // second tab bar view widget
                    Center(
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

