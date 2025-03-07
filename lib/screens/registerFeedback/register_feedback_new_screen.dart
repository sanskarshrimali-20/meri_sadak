import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_widget_svg.dart';
import '../../providerData/image_picker_provider.dart';
import '../../providerData/permission_provider.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/custom_gesture_container.dart';
import '../../widgets/custom_text_field.dart';
import '../location/location_widget.dart';

class RegisterFeedbackNewScreen extends StatefulWidget {
  const RegisterFeedbackNewScreen({super.key});

  @override
  State<RegisterFeedbackNewScreen> createState() =>
      _RegisterFeedbackNewScreen();
}

class _RegisterFeedbackNewScreen extends State<RegisterFeedbackNewScreen> {
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _roadNameController = TextEditingController();
  final TextEditingController _writeFeedbackController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String isClickedBy = AppStrings.noOne;
  bool _showFeedbackForm = true;

  @override
  void initState() {
    super.initState();
    _initializePermissionProvider();
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      appBar: CustomAppBar(
        title: AppStrings.registerFeedback,
        leadingIcon: ImageAssetsPath.backArrow,
      ),
      body: Consumer<ImagePickerProvider>(
        builder: (context, imagePickerProvider, child) {
          return CustomBodyWithGradient(
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
                  child: SizedBox(
                    child: Column(
                      children: [
                        _showFeedbackForm
                            ? feedbackForm(
                              imagePickerProvider,
                              permissionProvider,
                            )
                            : previewForm(imagePickerProvider),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
                          borderRadius: BorderRadius.circular(
                            AppDimensions.di_15,
                          ),
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
                                      },
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

  Widget feedbackForm(
    ImagePickerProvider imagePickerProvider,
    PermissionProvider permissionProvider,
  ) {
    return Column(
      children: [
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
              mapHeight: DeviceSize.getScreenHeight(context) * 0.25,
              mapWidth: DeviceSize.getScreenWidth(context),
              // * 0.8,
              onRefresh: () async {
                await permissionProvider.fetchCurrentLocation();
              },
              onMapTap: (point) async {
                await permissionProvider.setLocation(
                  point.latitude,
                  point.longitude,
                );
              },
            ),

        const SizedBox(height: AppDimensions.di_20),

        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.uploadRoadImages,
            fontSize: AppDimensions.di_16,
            color: AppColors.black,
          ),
        ),

        const SizedBox(height: AppDimensions.di_5),

        imagePickerProvider.imageFiles.isEmpty ||
                isClickedBy == AppStrings.camera
            ? CustomGestureContainer(
              text: AppStrings.openCameraText,
              icon: cameraSvg,
              onTap: () async {
                isClickedBy = AppStrings.camera;
                if (imagePickerProvider.imageFiles.length >= 3) {
                  showCustomSnackBar(context, AppStrings.imageLimitText);
                } else {
                  String? result = await imagePickerProvider.pickImage(
                    ImageSource.camera,
                  );
                  if (result != null) {
                    showCustomSnackBar(
                      context,
                      result,
                      backgroundColor: Colors.red,
                    );
                  }
                }
              },
              width: DeviceSize.getScreenWidth(context),
              height: 50,
              textColor: AppColors.selectImageColor,
            )
            : Container(),

        imagePickerProvider.imageFiles.isEmpty
            ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.di_10,
                horizontal: AppDimensions.di_25,
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
                  ),
                  Flexible(child: Divider()),
                ],
              ),
            )
            : Container(),

        imagePickerProvider.imageFiles.isEmpty ||
                isClickedBy == AppStrings.gallery
            ? CustomGestureContainer(
              text: AppStrings.selectImagesText,
              icon: gallerySvg,
              onTap: () async {
                isClickedBy = AppStrings.gallery;
                if (imagePickerProvider.imageFiles.length >= 3) {
                  showCustomSnackBar(context, AppStrings.imageLimitText);
                } else {
                  String? result = await imagePickerProvider.pickImage(
                    ImageSource.gallery,
                  );
                  if (result != null) {
                    showCustomSnackBar(
                      context,
                      result,
                      backgroundColor: Colors.red,
                    );
                  }
                }
              },
              width: DeviceSize.getScreenWidth(context),
              height: 50,
              textColor: AppColors.selectImageColor,
            )
            : Container(),

        const SizedBox(height: AppDimensions.di_10),

        // If no images are selected, show a message and icons
        imagePickerProvider.imageFiles.isEmpty
            ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                ],
              ),
            )
            : SizedBox(
              height: DeviceSize.getScreenHeight(context) * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: imagePickerProvider.imageFiles.length,
                itemBuilder: (context, index) {
                  final imageItem = imagePickerProvider.imageFiles[index];
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
                                imageItem.image.path,
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
                                child: Image.file(
                                  File(imageItem.image.path),
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
                                  size: AppDimensions.di_24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppDimensions.di_6),
                        GestureDetector(
                          onTap: () => imagePickerProvider.deleteImage(index),
                          child: Container(
                            width: AppDimensions.di_100,
                            padding: EdgeInsets.all(AppDimensions.di_6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(
                                AppDimensions.di_12,
                              ),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: AppDimensions.di_24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

        const SizedBox(height: AppDimensions.di_10),

        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.enterRoadDetails,
            fontSize: AppDimensions.di_16,
            color: AppColors.black,
          ),
        ),

        SizedBox(height: AppDimensions.di_5),

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

        CustomDropdownField(
          hintText: AppStrings.selectRoadName,
          textController: _roadNameController,
          items: [],
          dropdownHeight: AppDimensions.di_300,
          isRequired: false,
        ),

        CustomDropdownField(
          hintText: AppStrings.selectCategoryOfComplaint,
          textController: _stateController,
          items: [],
          dropdownHeight: AppDimensions.di_300,
          isRequired: false,
        ),

        CustomTextField(
          labelText: AppStrings.feedback,
          label: AppStrings.writeYourFeedback,
          controller: _writeFeedbackController,
          keyboardType: TextInputType.name,
          maxLines: 4,
          maxLength: 200,
          validator: null,
          isRequired: false,
        ),

        Align(
          alignment: Alignment.centerRight,
          child: CustomButton(
            text: AppStrings.preview,
            onPressed: () async {
              setState(() {
                _showFeedbackForm = false;
              });
            },
            textColor: AppColors.whiteColor,
            backgroundColor: AppColors.color_E77728,
            fontSize: AppDimensions.di_18,
            padding: EdgeInsets.symmetric(
              vertical: AppDimensions.di_6,
              horizontal: AppDimensions.di_15,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.di_100),
          ),
        ),
      ],
    );
  }

  Widget previewForm(ImagePickerProvider imagePickerProvider) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.roadLocation,
            fontSize: AppDimensions.di_16,
            color: AppColors.black,
            fontWeight: AppFontWeight.fontWeight500,
          ),
        ),
        SizedBox(height: 5),

        CustomTextField(
          labelText: AppStrings.feedback,
          label: AppStrings.location,
          controller: _locationController,
          keyboardType: TextInputType.name,
          maxLines: 1,
          maxLength: 30,
          validator: null,
          editable: false,
          isRequired: false,
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.roadImages,
            fontSize: AppDimensions.di_16,
            color: AppColors.black,
            fontWeight: AppFontWeight.fontWeight500,
          ),
        ),
        SizedBox(height: 10),

        imagePickerProvider.imageFiles.isEmpty
            ? const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

            ],
          ),
        )
            : SizedBox(
          height: DeviceSize.getScreenHeight(context) * 0.14,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            itemCount: imagePickerProvider.imageFiles.length,
            itemBuilder: (context, index) {
              final imageItem = imagePickerProvider.imageFiles[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.di_8,
                ),
                child: Column(
                  children: [
                    Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.di_8,
                            ),
                            child: Image.file(
                              File(imageItem.image.path),
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
                              size: AppDimensions.di_24,
                            ),
                          ),
                        ],
                      ),

                  ],
                ),
              );
            },
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.roadDetails,
            fontSize: AppDimensions.di_16,
            color: AppColors.black,
            fontWeight: AppFontWeight.fontWeight500,
          ),
        ),

        SizedBox(height: 5),

        Table(
          border: TableBorder.all(color: AppColors.textFieldBorderColor),
          columnWidths: {
            0: FixedColumnWidth(110.0),
            // Set fixed width for the first column
            1: FlexColumnWidth(1),
            // Set flexible width for the second column
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    text: AppStrings.state,
                    fontSize: AppDimensions.di_14,
                    color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cell 2'),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    text: AppStrings.district,
                    fontSize: AppDimensions.di_14,
                    color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cell 2'),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    text: AppStrings.block,
                    fontSize: AppDimensions.di_14,
                    color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cell 2'),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    text: AppStrings.roadName,
                    fontSize: AppDimensions.di_14,
                    color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cell 2'),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    text: AppStrings.categoryOfComplaint,
                    fontSize: AppDimensions.di_14,
                    color: AppColors.black,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cell 2'),
                ),
              ],
            ),
          ],
        ),
        Table(
          border: TableBorder.all(color: AppColors.textFieldBorderColor),
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: AppStrings.feedback,
                        fontSize: AppDimensions.di_14,
                        color: AppColors.black,
                        fontWeight: AppFontWeight.fontWeight500,
                      ),

                      CustomTextWidget(
                        text: AppStrings.feedbackDummy,
                        fontSize: AppDimensions.di_14,
                        color: AppColors.black,
                        maxlines: 5,
                        fontWeight: AppFontWeight.fontWeight400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 20),

        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                text: AppStrings.edit,
                onPressed: () async {
                  setState(() {
                    _showFeedbackForm = true;
                  });
                },
                textColor: AppColors.whiteColor,
                backgroundColor: AppColors.color_E77728,
                fontSize: AppDimensions.di_18,
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.di_6,
                  horizontal: AppDimensions.di_15,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.di_100),
              ),
            ),

            Spacer(),

            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: AppStrings.submit,
                onPressed: () async {},
                textColor: AppColors.whiteColor,
                backgroundColor: AppColors.color_E77728,
                fontSize: AppDimensions.di_18,
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.di_6,
                  horizontal: AppDimensions.di_15,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.di_100),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
