import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_widget_svg.dart';
import '../../providerData/image_picker_provider.dart';
import '../../providerData/permission_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_gesture_container.dart';
import '../../widgets/custom_text_widget.dart';
import '../location/location_widget.dart';

class UploadImageScreen extends StatefulWidget {
  final int stepIndex;
  final Function(int, bool, bool) isStepCompleted;
  const UploadImageScreen({
    super.key,
    required this.stepIndex,
    required this.isStepCompleted,
  });
  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool showCameraButton = false;
  bool showGalleryButton = false;

  @override
  void initState() {
    super.initState();
    _initializePermissionProvider();
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Consumer<ImagePickerProvider>(
            builder: (context, imagePickerProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      CustomTextWidget(
                        text: AppStrings.uploadImageInstructions,
                        fontSize: AppDimensions.di_16,
                        color: AppColors.blackMagicColor,
                        fontWeight: AppFontWeight.fontWeight500,
                        // textAlign: AppFontSizeWeight.textAlignCenter,
                        // letterSpacing: AppFontSizeWeight.letterSpacing_0_0,
                      ),
                      const SizedBox(height: 20),
                      CustomGestureContainer(
                        text: AppStrings.selectImagesText,
                        icon: gallerySvg,
                        // Your icon widget
                        onTap: () async {
                          String? result = await imagePickerProvider
                              .pickImage(ImageSource.gallery);
                          if (result != null) {
                            if (mounted) {
                              showCustomSnackBar(context, result,
                                  backgroundColor: Colors.red);
                            }
                          }
                        },
                        width: DeviceSize.getScreenWidth(context),
                        height: DeviceSize.getScreenHeight(context) * 0.15,
                        textColor: AppColors.selectImageColor,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.44, // Vertical padding
                          horizontal: 25, // Horizontal padding
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(child: Divider()),
                            CustomTextWidget(
                              text: ' or ',
                              fontSize: AppDimensions.di_14,
                              color: AppColors.selectImageColor,
                              fontWeight: AppFontWeight.fontWeight500,
                              // textAlign: AppFontSizeWeight.textAlignCenter,
                              // letterSpacing: AppFontSizeWeight.letterSpacing_0_0,
                            ),
                            Flexible(child: Divider()),
                          ],
                        ),
                      ),
                      //if (showGalleryButton)
                      CustomGestureContainer(
                        text: AppStrings.openCameraText,
                        icon: cameraSvg,
                        // Your icon widget
                        onTap: () {
                          if(imagePickerProvider.imageFiles.length == 3){
                            showCustomSnackBar(context, AppStrings.imageLimitText);
                          }else{
                            _showLocationBottomSheet(DeviceSize.getScreenHeight(context), DeviceSize.getScreenWidth(context),
                                permissionProvider, imagePickerProvider);
                          }
                        },
                        width: DeviceSize.getScreenWidth(context) * 0.8,
                        height: DeviceSize.getScreenHeight(context) * 0.09,
                        textColor: AppColors.selectImageColor,
                      ),
                      const SizedBox(height: 20),
                      Text(
                          '${AppStrings.imagesUploaded} (${imagePickerProvider.imageFiles.length}/3)',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Note: ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Maximum 3 images are allowed for feedback'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      imagePickerProvider.imageFiles.isEmpty
                          ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.image,
                                size: 50,
                                color: AppColors.selectImageColor,
                              ),
                              Text(AppStrings.noImagesUploaded),
                            ],
                          ))
                          : SizedBox(
                        height: DeviceSize.getScreenHeight(context) * 0.2,
                        child: ListView.builder(
                          scrollDirection:
                          Axis.horizontal, // Horizontal scrolling
                          itemCount: imagePickerProvider.imageFiles.length,
                          itemBuilder: (context, index) {
                            final imageItem =
                            imagePickerProvider.imageFiles[index];
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _showProfileImageDialog(
                                        context,
                                        imageItem.image.path,
                                        DeviceSize.getScreenHeight(context),
                                        DeviceSize.getScreenWidth(context),
                                        permissionProvider,
                                        imageItem.source),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          // Optional rounded corners
                                          child: Image.file(
                                            File(imageItem.image.path),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: AppColors.blackMagicColor,
                                            size: 24, // Icon size
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  GestureDetector(
                                    onTap: () => imagePickerProvider
                                        .deleteImage(index),
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 24, // Icon size
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if (imagePickerProvider.imageFiles.isNotEmpty)
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomButton(
                            text: AppStrings.clearAllImagesText,
                            onPressed: () => imagePickerProvider.clearImages(),
                            icon: Icons.clear,
                            iconColor: AppColors.blackMagicColor,
                            textColor: AppColors.blackMagicColor,
                            backgroundColor: Colors.white,
                            fontSize: AppDimensions.di_15,
                            padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomButton(
                          text: AppStrings.next,
                          onPressed: () async {
                            widget.isStepCompleted(widget.stepIndex, true, false);
                          },
                          icon: Icons.arrow_forward,
                          iconColor: AppColors.whiteColor,
                          textColor: AppColors.whiteColor,
                          backgroundColor: AppColors.color_E77728,
                          fontSize: AppDimensions.di_18,
                          padding:
                          EdgeInsets.symmetric(vertical: 06, horizontal: 15),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }));
  }

  void _showLocationBottomSheet(double screenHeight, double screenWidth,
      PermissionProvider permissionProvider, ImagePickerProvider imgProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to be scrollable
      backgroundColor: Colors.transparent, // Make the background transparent
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.75,
          // Set height for the bottom sheet
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title Header
              const Text(
                AppStrings.confirmLocationHeading,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),

              // Map View
              Expanded(
                child: permissionProvider.isLoading
                    ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                    : CustomLocationWidget(
                  labelText: AppStrings.currentLocationLabel,
                  isRequired: true,
                  latitude: permissionProvider.latitude,
                  longitude: permissionProvider.longitude,
                  initialAddress: permissionProvider.address.toString(),
                  isLoading: permissionProvider.isLoading,
                  mapHeight: screenHeight * 0.4,
                  mapWidth: screenWidth,
                  // * 0.8,
                  onRefresh: () async {
                    await permissionProvider.fetchCurrentLocation();
                  },
                  onMapTap: (point) async {
                    await permissionProvider.setLocation(
                        point.latitude, point.longitude);
                  },
                ),
              ),
              Container(
                color: Colors.yellow[100],
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 4.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                    Flexible(child: Text(permissionProvider.address)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Call the function to pick the image first
                      String? result =
                      await imgProvider.pickImage(ImageSource.camera);
                      // Show the SnackBar based on the result
                      if (result != null) {
                        if (mounted) {
                          showCustomSnackBar(context, result,
                              backgroundColor: Colors.red);
                        }
                      }
                      // Pop the screen after showing the SnackBar
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Button color for cancel
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _initializePermissionProvider() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Initialize permissionProvider after the widget is built
      final provider = Provider.of<PermissionProvider>(context, listen: false);
      // Ensure permissionProvider is available
      await provider.requestLocationPermission();
      await provider.fetchCurrentLocation();
        });
  }

  void _showProfileImageDialog(BuildContext context, String picPath, screenH,
      screenW, PermissionProvider permissionProvider, String imgSource) {
    print("imgSource--$imgSource");

    if (picPath.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows for custom height
        builder: (context) => Container(
          height: imgSource == 'Camera' ? screenH * 0.75 : screenH * 0.5,
          width: screenW,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)), // Rounded top corners
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      // Rounded corners for image
                      child: Image.file(
                        File(picPath),
                        width: screenW * 0.8, // Image width responsive
                        height: screenH * 0.3, // Image height responsive
                        fit: BoxFit.contain,
                      ),
                    ),
                    if (imgSource == 'Camera')
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: permissionProvider.isLoading
                            ? Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator())
                            : CustomLocationWidget(
                          labelText: AppStrings.currentLocationLabel,
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
                                point.latitude, point.longitude);
                          },
                        ),
                      ),
                    if (imgSource == 'Camera')
                      Container(
                        color: Colors.yellow[100],
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          spacing: 4.0,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.red,
                            ),
                            Flexible(child: Text(permissionProvider.address)),
                          ],
                        ),
                      ),
                    SizedBox(height: 16),
                    // Add some spacing before the button
                    /* CustomButton(
                      text: 'Close',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icons.close,
                      iconColor: AppColors.whiteColor,
                      textColor: AppColors.whiteColor,
                      backgroundColor: AppColors.toastBgColorRed,
                      fontSize: AppFontSizeWeight.fontSize15,
                      iconSize: 20,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      borderRadius: BorderRadius.circular(100),
                    ),*/
                  ],
                ),
              ),
              Positioned(
                right: 1,
                top: 2,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 20,
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
      showCustomSnackBar(context, AppStrings.noProfileImageAvailable,
          backgroundColor: Colors.red);
    }
  }

  void showCustomSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
