import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../widgets/custom_body_with_gradient.dart';
import 'feedback_details_screen.dart';

class AllFeedbackSecondScreen extends StatefulWidget {
  const AllFeedbackSecondScreen({super.key});

  @override
  State<AllFeedbackSecondScreen> createState() => _AllFeedbackSecondScreen();
}

class _AllFeedbackSecondScreen extends State<AllFeedbackSecondScreen> with SingleTickerProviderStateMixin {

  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> submitFeedbackList = []; // List to hold feedback data
  List<Map<String, dynamic>> savedFeedbackList = []; // List to hold feedback data
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchAllFeedback(); // Fetch feedback data when the widget is initialized
  }

  Future<void> fetchAllFeedback() async {
    final submitFeedbacks =
    await dbHelper
        .getFeedbacksByFinalSubmitStatus(true); // Assuming you have this method in your provider
    final savedFeedbacks =
    await dbHelper
        .getFeedbacksByFinalSubmitStatus(false); // Assuming you have this method in your provider
    setState(() {
      debugPrint("submitFeedbacks list$submitFeedbacks");
      submitFeedbackList = submitFeedbacks; // Update the state with fetched feedback
      savedFeedbackList = savedFeedbacks;
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
                      dividerColor: themeProvider.themeMode == ThemeMode.light
                          ? AppColors.whiteColor
                          : AppColors.black,
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
                        // First tab: Submitted Feedbacks
                        submitFeedbackList.isEmpty
                            ? Center(
                          child: Text(
                            'No results available',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                            : ListView.builder(
                          itemCount: submitFeedbackList.length,
                          itemBuilder: (context, index) {
                            final feedback = submitFeedbackList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FeedbackDetailsScreen(id: feedback['id']),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          text: "Feedback ID: ${feedback['id']}",
                                          fontSize: AppDimensions.di_16,
                                          color:  themeProvider.themeMode == ThemeMode.light
                                              ? AppColors.black
                                              : AppColors.whiteColor,
                                          fontWeight: AppFontWeight.fontWeight600,
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: <Color>[
                                                AppColors.blueGradientColor1,
                                                AppColors.blueGradientColor2,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(AppDimensions.di_40),
                                            ),
                                          ),
                                          width: 80,
                                          height: 23,
                                          child: Center(
                                            child: Text(
                                              "Submitted",
                                              style: TextStyle(color: AppColors.whiteColor),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        SvgPicture.asset(ImageAssetsPath.rightArrow, color: themeProvider.themeMode == ThemeMode.light
                                            ? AppColors.black
                                            : AppColors.whiteColor,),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Divider(
                                      color: Colors.grey.withAlpha(60),
                                      thickness: AppDimensions.di_1,
                                      indent: AppDimensions.di_1,
                                      endIndent: AppDimensions.di_11,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Second tab: Saved Feedbacks
                        savedFeedbackList.isEmpty
                            ? Center(
                          child: Text(
                            'No results available',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                            : ListView.builder(
                          itemCount: savedFeedbackList.length,
                          itemBuilder: (context, index) {
                            final feedback = savedFeedbackList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FeedbackDetailsScreen(id: feedback['id']),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          text: "Feedback ID: ${feedback['id']}",
                                          fontSize: AppDimensions.di_16,
                                          color:  themeProvider.themeMode == ThemeMode.light
                                              ? AppColors.black
                                              : AppColors.whiteColor,fontWeight: AppFontWeight.fontWeight600,
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: <Color>[
                                                AppColors.blueGradientColor1,
                                                AppColors.blueGradientColor2,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(AppDimensions.di_40),
                                            ),
                                          ),
                                          width: 120,
                                          height: 23,
                                          child: Center(
                                            child: Text(
                                              "To be submitted",
                                              style: TextStyle(color: AppColors.whiteColor),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        SvgPicture.asset(ImageAssetsPath.rightArrow, color: themeProvider.themeMode == ThemeMode.light
                                            ? AppColors.black
                                            : AppColors.whiteColor,),],
                                    ),
                                    SizedBox(height: 10),
                                    Divider(
                                      color: Colors.grey.withAlpha(60),
                                      thickness: AppDimensions.di_1,
                                      indent: AppDimensions.di_1,
                                      endIndent: AppDimensions.di_11,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

