import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/screens/allFeedback/feedback_details_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../providerData/permission_provider.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_carousel_slider.dart';
import '../../widgets/custom_expansion_tile.dart';
import '../location/location_widget.dart';

class AllFeedbackScreen extends StatefulWidget {
  const AllFeedbackScreen({super.key});

  @override
  State<AllFeedbackScreen> createState() => _AllFeedbackScreen();
}

class _AllFeedbackScreen extends State<AllFeedbackScreen> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> feedbackList = []; // List to hold feedback data

  @override
  void initState() {
    super.initState();
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
      backgroundColor:
          themeProvider.themeMode == ThemeMode.light
              ? AppColors.bgColorGainsBoro
              : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title: AppStrings.feedbackStatus,
        childHeight: DeviceSize.getScreenHeight(context),
        child:
            feedbackList.isEmpty
                ? Center(
                  child: CustomTextWidget(
                    text: AppStrings.noDataAvailable,
                    fontSize: AppDimensions.di_14,
                    color: AppColors.blackMagicColor,
                  ),
                )
                : ListView.builder(
                  itemCount: feedbackList.length,
                  itemBuilder: (context, index) {
                    final feedback = feedbackList[index];
                    print(
                      "Feedback isFinalSubmit: ${feedback['isFinalSubmit']}",
                    );
                    return CustomExpansionTile(
                      title: "Feedback ID: ${feedback['id']}",
                      subheading:
                          "Status: ${feedback['isFinalSubmit'] == 1 ? 'Submitted' : 'To be Submitted'}",
                      content: Text(feedback['feedback'] ?? 'No Feedback'),
                      initiallyExpanded: false,
                      // You can set this dynamically if needed
                      backgroundColor:
                          themeProvider.themeMode == ThemeMode.light
                              ? AppColors.whiteColor
                              : AppColors.boxDarkModeColor,
                      textColor:
                          themeProvider.themeMode == ThemeMode.light
                              ? AppColors.black
                              : AppColors.whiteColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    FeedbackDetailsScreen(id: feedback['id']),
                          ),
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
