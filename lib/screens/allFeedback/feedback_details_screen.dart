import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meri_sadak/data/model/image_item_model.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../widgets/custom_body_with_gradient.dart';

class FeedbackDetailsScreen extends StatefulWidget {
  final int id;

  FeedbackDetailsScreen({super.key, required this.id});

  @override
  State<FeedbackDetailsScreen> createState() => _FeedbackDetailsScreen();
}

class _FeedbackDetailsScreen extends State<FeedbackDetailsScreen> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>>? feedbackData; // Update to handle a list of feedback
  bool isLoading = true; // State variable to track loading status

  @override
  void initState() {
    super.initState();
    fetchFeedback(); // Fetch feedback data when the widget is initialized
  }

  Future<void> fetchFeedback() async {
    var fetchedFeedback = await dbHelper.getFeedbackWithImages(widget.id);
    // Assuming fetchedFeedback contains QueryRow or similar structure
    setState(() {
      feedbackData = fetchedFeedback.map((item) {
        // Convert each item to a Map<String, dynamic>
        Map<String, dynamic> feedbackItem = item;

        // Convert images from QueryRow to ImageItem instances
        if (feedbackItem['images'] != null) {
          feedbackItem['images'] = (feedbackItem['images'] as List)
              .map((image) => ImageItem.fromMap(image)) // Assuming you have a fromJson method in ImageItem
              .toList();
        }

        return feedbackItem;
      }).toList();

      isLoading = false; // Set loading to false once data is fetched
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
        childHeight: DeviceSize.getScreenHeight(context),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.di_5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.di_20), // Rounded corners
              ),
            ),
            padding: EdgeInsets.all(AppDimensions.di_15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (feedbackData != null && feedbackData!.isNotEmpty)
                    ...feedbackData!.map((feedback) {
                      return Container(
                        width: DeviceSize.getScreenWidth(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: "State: ${feedback['state']}",
                              fontSize: 18,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextWidget(
                              text: "District: ${feedback['district']}",
                              fontSize: 18,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextWidget(
                              text: "Block: ${feedback['block']}",
                              fontSize: 18,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextWidget(
                              text: "Complaint: ${feedback['categoryOfComplaint']}",
                              fontSize: 18,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: DeviceSize.getScreenHeight(context) * 0.15,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                (feedback['images'] as List).length,
                                itemBuilder: (context, index) {
                                  ImageItem imageItem =
                                  feedback['images'][index];
                                  debugPrint("Imagepath${imageItem.imagePath}");
                                  File imageFile = File(imageItem.imagePath);
                                  return Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: AppDimensions.di_8),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.file(imageFile, width: 100, height: 100, fit: BoxFit.cover,),  // Use Image.file to load the image from the file system// Placeholder image
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList()
                  else
                    Center(child: Text('No feedback available')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
