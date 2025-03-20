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
            padding: const EdgeInsets.all(AppDimensions.di_1),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppDimensions.di_30),
                  CustomTextWidget(
                    text: AppStrings.uploadImageInstructions,
                    fontSize: AppDimensions.di_18,
                    color: AppColors.blackMagicColor,
                    fontWeight: AppFontWeight.fontWeight500,
                    textAlign: TextAlign.center,
                    // textAlign: AppFontSizeWeight.textAlignCenter,
                    // letterSpacing: AppFontSizeWeight.letterSpacing_0_0,
                  ),
                  const SizedBox(height: AppDimensions.di_20),
                  CustomGestureContainer(
                    text: AppStrings.selectImagesText,
                    icon: gallerySvg,
                    // Your icon widget
                    onTap: () async {
                      String? result = await imagePickerProvider.pickImage(
                        ImageSource.gallery,
                      );
                      if (result != null) {
                        if (mounted) {
                          showCustomSnackBar(
                            context,
                            result,
                            backgroundColor: Colors.red,
                          );
                        }
                      }
                    },
                    width: DeviceSize.getScreenWidth(context),
                    height: DeviceSize.getScreenHeight(context) * 0.09,
                    textColor: AppColors.selectImageColor,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.di_20, // Vertical padding
                      horizontal: AppDimensions.di_25, // Horizontal padding
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(child: Divider()),
                        CustomTextWidget(
                          text: ' or ',
                          fontSize: AppDimensions.di_16,
                          color: AppColors.black,
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
                      if (imagePickerProvider.imageFiles.length == 3) {
                        showCustomSnackBar(context, AppStrings.imageLimitText);
                      } else {
                        _showLocationBottomSheet(
                          DeviceSize.getScreenHeight(context),
                          DeviceSize.getScreenWidth(context),
                          permissionProvider,
                          imagePickerProvider,
                        );
                      }
                    },
                    width: DeviceSize.getScreenWidth(context) * 0.8,
                    height: DeviceSize.getScreenHeight(context) * 0.09,
                    textColor: AppColors.selectImageColor,
                  ),
                  const SizedBox(height: AppDimensions.di_20),
                  Text(
                    '${AppStrings.imagesUploaded} (${imagePickerProvider.imageFiles.length}/3)',
                    style: TextStyle(fontSize: AppDimensions.di_18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppDimensions.di_10),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Note: ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Maximum 3 images are allowed for feedback',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.di_10),
                  imagePickerProvider.imageFiles.isEmpty
                      ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image,
                              size: AppDimensions.di_50,
                              color: AppColors.selectImageColor,
                            ),
                            Text(AppStrings.noImagesUploaded),
                          ],
                        ),
                      )
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.di_8,
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap:
                                        () => _showProfileImageDialog(
                                          context,
                                          imageItem.imagePath,
                                          DeviceSize.getScreenHeight(context),
                                          DeviceSize.getScreenWidth(context),
                                          permissionProvider,
                                          imageItem.source,
                                        ),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            AppDimensions.di_8,
                                          ),
                                          // Optional rounded corners
                                          child: Image.file(
                                            File(imageItem.imagePath),
                                            width: AppDimensions.di_100,
                                            height: AppDimensions.di_100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: AppDimensions.di_8,
                                          right: AppDimensions.di_8,
                                          child: Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: AppColors.blackMagicColor,
                                            size: AppDimensions.di_24, // Icon size
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: AppDimensions.di_6),
                                  GestureDetector(
                                    onTap:
                                        () => imagePickerProvider.deleteImage(
                                          index,
                                        ),
                                    child: Container(
                                      width: AppDimensions.di_100,
                                      padding: EdgeInsets.all(AppDimensions.di_6),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(AppDimensions.di_12),
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: AppDimensions.di_24, // Icon size
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
                        textColor: AppColors.blackMagicColor,
                        backgroundColor: Colors.white,
                        fontSize: AppDimensions.di_15,
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.di_6,
                          horizontal: AppDimensions.di_12,
                        ),
                        borderRadius: BorderRadius.circular(AppDimensions.di_12),
                      ),
                    ),
                  const SizedBox(height: AppDimensions.di_20),

                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      text: AppStrings.next,
                      onPressed: () async {
                        widget.isStepCompleted(widget.stepIndex, true, false);
                      },
                      textColor: AppColors.whiteColor,
                      backgroundColor: AppColors.color_E77728,
                      fontSize: AppDimensions.di_18,
                      padding:
                      EdgeInsets.symmetric(vertical: AppDimensions.di_6, horizontal: AppDimensions.di_15),
                      borderRadius: BorderRadius.circular(AppDimensions.di_100),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.di_20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLocationBottomSheet(
    double screenHeight,
    double screenWidth,
    PermissionProvider permissionProvider,
    ImagePickerProvider imgProvider,
  ) {
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
              topLeft: Radius.circular(AppDimensions.di_16),
              topRight: Radius.circular(AppDimensions.di_16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: AppDimensions.di_10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppDimensions.di_16),
          child: Column(
            children: [
              // Title Header
              const Text(
                AppStrings.confirmLocationHeading,
                style: TextStyle(
                  fontSize: AppDimensions.di_24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: AppDimensions.di_10),

              // Map View
              Expanded(
                child:
                    permissionProvider.isLoading
                        ? Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )
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
                              point.latitude,
                              point.longitude,
                            );
                          }, onMapReady: () {  },
                        ),
              ),
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
                    Flexible(child: Text(permissionProvider.address)),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.di_10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Call the function to pick the image first
                      String? result = await imgProvider.pickImage(
                        ImageSource.camera,
                      );
                      // Show the SnackBar based on the result
                      if (result != null) {
                        if (mounted) {
                          showCustomSnackBar(
                            context,
                            result,
                            backgroundColor: Colors.red,
                          );
                        }
                      }
                      // Pop the screen after showing the SnackBar
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.di_12,
                        horizontal: AppDimensions.di_30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.di_30),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: AppDimensions.di_16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.di_20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Button color for cancel
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.di_12,
                        horizontal: AppDimensions.di_30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.di_30),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: AppDimensions.di_16,
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

  void _showProfileImageDialog(
    BuildContext context,
    String picPath,
    screenH,
    screenW,
    PermissionProvider permissionProvider,
    String imgSource,
  ) {
    print("imgSource--$imgSource");

    if (picPath.isNotEmpty) {
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
                          borderRadius: BorderRadius.circular(AppDimensions.di_15),
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
                            padding: const EdgeInsets.symmetric(vertical: AppDimensions.di_8),
                            child:
                                permissionProvider.isLoading
                                    ? Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    )
                                    : CustomLocationWidget(
                                      labelText:
                                          AppStrings.currentLocationLabel,
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
                                      }, onMapReady: () {  },
                                    ),
                          ),
                        if (imgSource == 'Camera')
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
                          ),
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
