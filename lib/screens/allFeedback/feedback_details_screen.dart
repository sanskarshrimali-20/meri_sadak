import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/data/model/image_item_model.dart';
import 'package:meri_sadak/utils/date_time_utils.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../providerData/permission_provider.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/EncryptionService/encryption_service.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/drawer_widget.dart';
import '../location/location_widget.dart';
import '../registerFeedback/register_feedback_new_screen.dart';

class FeedbackDetailsScreen extends StatefulWidget {

  final int id;

  const FeedbackDetailsScreen({super.key, required this.id});

  @override
  State<FeedbackDetailsScreen> createState() => _FeedbackDetailsScreen();
}

class _FeedbackDetailsScreen extends State<FeedbackDetailsScreen> {

  final EncryptionService _encryptionService = EncryptionService();
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>>?
  feedbackData; // Update to handle a list of feedback
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
      feedbackData =
          fetchedFeedback.map((item) {
            // Convert each item to a Map<String, dynamic>
            Map<String, dynamic> feedbackItem = item;

            // Convert images from QueryRow to ImageItem instances
            if (feedbackItem['images'] != null) {
              feedbackItem['images'] =
                  (feedbackItem['images'] as List)
                      .map(
                        (image) => ImageItem.fromMap(image),
                      ) // Assuming you have a fromJson method in ImageItem
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
        title: AppStrings.feedbackDetails,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (feedbackData != null && feedbackData!.isNotEmpty)
                    ...feedbackData!.map((feedback) {
                      return
                        SizedBox(
                        width: DeviceSize.getScreenWidth(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomTextWidget(text: "Feedback ID: ${feedback['id']}", fontSize: AppDimensions.di_16,
                                  color: themeProvider.themeMode == ThemeMode.light
                                    ? AppColors.black
                                    : AppColors.whiteColor,
                                  fontWeight: AppFontWeight.fontWeight600,),
                                Spacer(),
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
                                  width: feedback["isFinalSubmit"] == 1 ? 100 : 140,
                                  height: 30,
                                  child: Center(
                                    child: Text(feedback["isFinalSubmit"] == 1 ? "Submitted" : "To be submitted", style: TextStyle(color: AppColors.whiteColor),),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),


                            CustomTextWidget(
                              text:
                              "Submitted: ${DateTimeUtil.formatDateTime(decryptString(feedback["dateTime"]))}",
                              // "submitted: ${feedback['categoryOfComplaint']}",
                              fontSize: 16,
                              fontWeight: AppFontWeight.fontWeight600,
                              color: AppColors.primaryColor,
                            ),

                            SizedBox(height: 10),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 17),
                                children: [
                                  TextSpan(
                                    text: 'Complaint: ',
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.fontWeight500,
                                      color:  themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.whiteColor, ),
                                  ),
                                  TextSpan(
                                    text: decryptString(feedback['categoryOfComplaint']),
                                    style: TextStyle( fontWeight: AppFontWeight.fontWeight400,
                                      color:  themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.black.withAlpha(200)
                                          : AppColors.whiteColor.withAlpha(200), fontSize: AppDimensions.di_16),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 17),
                                children: [
                                  TextSpan(
                                    text: 'Road: ',
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.fontWeight500,
                                      color:  themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.whiteColor, ),
                                  ),
                                  TextSpan(
                                    text: decryptText(feedback["roadName"]).isEmpty ? decryptText(feedback["staticRoadName"]) :
                                    decryptText(feedback["roadName"]),
                                    style: TextStyle( fontWeight: AppFontWeight.fontWeight400,
                                      color:  themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.black.withAlpha(200)
                                          : AppColors.whiteColor.withAlpha(200), fontSize: AppDimensions.di_16),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 17),
                                children: [
                                  TextSpan(
                                    text: 'Feedback: ',
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.fontWeight500,
                                      color:  themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.whiteColor,),
                                  ),
                                  TextSpan(
                                    text: decryptString(feedback["feedback"]),
                                    style: TextStyle( fontWeight: AppFontWeight.fontWeight400,
                                      color:  themeProvider.themeMode == ThemeMode.light
                                          ? AppColors.black.withAlpha(200)
                                          : AppColors.whiteColor.withAlpha(200), fontSize: AppDimensions.di_16),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 15),

                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.color_E77728
                              ),
                              child:  CustomTextWidget(
                                text:"  ${AppStrings.piuDetails}  ",
                                fontSize: 18,
                                fontWeight: AppFontWeight.fontWeight600,
                                color: AppColors.whiteColor,
                              ),
                            ),

                            SizedBox(height: 10),

                            customDrawerWidget(
                              title: "Sanskar",
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                                icon: ImageAssetsPath.user,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                              visible: false
                            ),

                            customDrawerWidget(
                              title: "sanskars@cdac.in",
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                              icon: ImageAssetsPath.mail,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                                visible: false
                            ),

                            customDrawerWidget(
                              title: "9876543210",
                              icon: ImageAssetsPath.phone,
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                                visible: false
                            ),

                            customDrawerWidget(
                                title: decryptString(feedback["district"]),
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                              icon: ImageAssetsPath.locationPin,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                                visible: false
                            ),

                            customDrawerWidget(
                              title: decryptString(feedback["state"]),
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                              icon: ImageAssetsPath.locationPin,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                                visible: false
                            ),

                            SizedBox(height: 15,),

                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.color_E77728
                              ),
                              child:  CustomTextWidget(
                                text:"  ${AppStrings.sqcDetails}  ",
                                fontSize: 18,
                                fontWeight: AppFontWeight.fontWeight600,
                                color: AppColors.whiteColor,
                              ),
                            ),

                            SizedBox(height: 10),

                            customDrawerWidget(
                              title: "S.d pendse",
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                              icon: ImageAssetsPath.user,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                                visible: false
                            ),

                            customDrawerWidget(
                              title: "mp-sqc@nic.in",
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                              icon: ImageAssetsPath.mail,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                                visible: false
                            ),

                            customDrawerWidget(
                              title: "9876543210",
                              icon: ImageAssetsPath.phone,
                                fontSize: AppDimensions.di_16,
                                fontWeight: AppFontWeight.fontWeight600,
                              textColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              iconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                              suffixIconColor: themeProvider.themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.whiteColor, onClick: () {  },
                                visible: false
                            ),

                            SizedBox(height: 15,),

                            SizedBox(
                              height: DeviceSize.getScreenHeight(context) * 0.15,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (feedback['images'] as List).length,
                                itemBuilder: (context, index) {
                                  ImageItem imageItem =
                                      feedback['images'][index];
                                  File imageFile = File(imageItem.imagePath);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimensions.di_8,
                                    ),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _showProfileImageDialog(
                                              context,
                                              imageItem,
                                              DeviceSize.getScreenHeight(context),
                                              DeviceSize.getScreenWidth(context),
                                              Provider.of<PermissionProvider>(context, listen: false),
                                              imageItem.source,
                                            );
                                          },
                                          child: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: Image.file(
                                              imageFile,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ), // Use Image.file to load the image from the file system// Placeholder image
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                          SizedBox(height: 15,),

                            if (feedback['isFinalSubmit'] == 0)
                              GestureDetector(
                              child: Container(
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
                                width: 100,
                                height: 50,
                                child: Center(
                                  child: Text("Edit", style: TextStyle(color: AppColors.whiteColor, fontSize: AppDimensions.di_16,
                                      fontWeight: AppFontWeight.fontWeight600),),
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                        RegisterFeedbackNewScreen(
                                          feedbackId: feedback['id'],
                                        ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    })
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

  // Helper function for encryption
  String decryptString(String? value) {
    return _encryptionService.decrypt(value?.trim() ?? '');
  }

  String decryptText(String text) {
    if (text.isEmpty) {
      // Handle empty string - return an empty string or a default value
      return '';
    }
    return decryptString(text); // Assuming decryptString is your decryption method
  }

  void _showProfileImageDialog(
      BuildContext context,
      ImageItem imageItem,
      screenH,
      screenW,
      PermissionProvider permissionProvider,
      String imgSource,
      ) {
    if (imageItem.imagePath.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows for custom height
        builder:
            (context) => Container(
          height: imgSource == 'Camera' ? screenH * 0.75 : screenH * 0.5,
          width: screenW,
          padding: EdgeInsets.all(AppDimensions.di_8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.di_30),
            ), // Rounded top corners
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppDimensions.di_10,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.di_15,
                      ),
                      // Rounded corners for image
                      child: Image.file(
                        File(imageItem.imagePath),
                        width: screenW * 0.8, // Image width responsive
                        height: screenH * 0.3, // Image height responsive
                        fit: BoxFit.contain,
                      ),
                    ),
                    /*CustomTextWidget(text: imageItem.time, fontSize: AppDimensions.di_16, color: AppColors.black),
                        CustomTextWidget(text: imageItem.lat, fontSize: AppDimensions.di_16, color: AppColors.black),*/
                    if (imgSource == 'Camera')
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.di_8,
                        ),
                        child:
                        permissionProvider.isLoading
                            ? Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )
                            : CustomLocationWidget(
                          labelText:
                          AppStrings.confirmTheRoadLocation,
                          isRequired: false,
                          latitude: permissionProvider.latitude,
                          longitude: permissionProvider.longitude,
                          initialAddress:
                          permissionProvider.address.toString(),
                          isLoading: permissionProvider.isLoading,
                          mapHeight: screenH * 0.2,
                          mapWidth: screenW,
                          onRefresh: () async {
                            await permissionProvider
                                .fetchCurrentLocation();
                          },
                          onMapTap: (point) async {
                            await permissionProvider.setLocation(
                              point.latitude,
                              point.longitude,
                            );
                          },
                          onMapReady: () {},
                        ),
                      ),
                    /* if (imgSource == 'Camera')
                          Container(
                            color: Colors.yellow[100],
                            padding: EdgeInsets.all(AppDimensions.di_8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              spacing: AppDimensions.di_4,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_pin, color: Colors.red),
                                Flexible(
                                  child: Text(permissionProvider.address),
                                ),
                              ],
                            ),
                          ),*/
                    SizedBox(height: AppDimensions.di_16),
                  ],
                ),
              ),
              Positioned(
                right: 1,
                top: 2,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: AppDimensions.di_20,
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      showCustomSnackBar(
        context,
        AppStrings.noProfileImageAvailable,
        backgroundColor: Colors.red,
      );
    }
  }

  void showCustomSnackBar(
      BuildContext context,
      String message, {
        Color backgroundColor = Colors.red,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ),
    );
  }

}
