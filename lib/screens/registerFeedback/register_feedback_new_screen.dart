import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_sadak/screens/home/home_screen.dart';
import 'package:meri_sadak/screens/registerFeedback/submitted_feedback_scree.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_font_weight.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_widget_svg.dart';
import '../../data/model/feedback_from_model.dart';
import '../../data/model/image_item_model.dart';
import '../../providerData/image_picker_provider.dart';
import '../../providerData/permission_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';
import '../../utils/device_size.dart';
import '../../utils/toast_util.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_confirmation_dialog.dart';
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
  final TextEditingController _staticRoadNameController =
      TextEditingController();
  final TextEditingController _writeFeedbackController =
      TextEditingController();
  final TextEditingController _categoryOfComplaintController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String? isClickedBy = AppStrings.noOne;
  bool _showFeedbackForm = true;
  bool _isLoading = false;
  bool roadNameEnable = false;
  final dbHelper = DatabaseHelper();
  final _storage = LocalSecureStorage(); // Secure storage instance
  final String currentAddress = "";

  String? selectedState;
  String? selectedDistrict;
  String? selectedBlock;
  String? selectedRoad;

  List<String> selectedDistricts = [];
  List<String> selectedBlocks = [];
  List<String> selectedRoads = []; // New list for roads

  late FeedbackFormData? feedbackData;

  // Sample data
  final List<String> states = [
    'Madhya Pradesh',
    'Uttar Pradesh',
    'Maharashtra',
    'Gujarat',
  ];

  final Map<String, List<String>> districts = {
    'Madhya Pradesh': ['Bhopal', 'Indore'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur'],
    'Maharashtra': ['Mumbai', 'Pune'],
    'Gujarat': ['Ahmedabad', 'Surat'],
  };

  final Map<String, List<String>> roadNames = {
    'Berasia': ['Berasia road', 'Berasia road Second', 'Enter Manually'],
    'Raisen': ['Raisen road', 'Raisen road Second', 'Enter Manually'],
    'Mhow': ['Mhow road', 'Mhow road Second', 'Enter Manually'],
    'Sanwer': ['Sanwer road', 'Sanwer road Second', 'Enter Manually'],
    'Malihabad': ['Malihabad road', 'Malihabad road Second', 'Enter Manually'],
    'Mau': ['Mau road', 'Mau road Second', 'Enter Manually'],
    'Sadar': ['Sadar road', 'Sadar road Second', 'Enter Manually'],
    'Vijay Nagar': [
      'Vijay Nagar road Second',
      'Vijay Nagar road',
      'Enter Manually',
    ],
    'Bandra': ['Bandra road', 'Bandra road Second', 'Enter Manually'],
    'Andheri': ['Andheri road', 'Andheri road Second', 'Enter Manually'],
    'Mulshi': ['Mulshi road', 'Mulshi road Second', 'Enter Manually'],
    'Haveli': ['Haveli road', 'Haveli road Second', 'Enter Manually'],
    'Daskroi': ['Daskroi road', 'Daskroi road Second', 'Enter Manually'],
    'Sanand': ['Sanand road', 'Sanand road Second', 'Enter Manually'],
    'Choryasi': ['Choryasi road', 'Choryasi road Second', 'Enter Manually'],
    'Ichhpur': ['Ichhpur road', 'Ichhpur road Second', 'Enter Manually'],
  };

  final List<String> complaints = [
    '1. Missing or unclear road signs, causing confusion for drivers and pedestrians.',
    '2. Absence of pedestrian crossings or footpaths, posing safety risks to pedestrians.',
    '3. Ongoing construction causing road damage or detours without proper maintenance.',
    '4. Unnecessary or poorly placed speed breakers causing disruption to traffic flow.',
    '5. The road surface is cracked and uneven, causing discomfort and potential accidents.'
  ];

  final Map<String, List<String>> blocks = {
    'Bhopal': ['Berasia', 'Raisen'],
    'Indore': ['Mhow', 'Sanwer'],
    'Lucknow': ['Malihabad', 'Mau'],
    'Kanpur': ['Sadar', 'Vijay Nagar'],
    'Mumbai': ['Bandra', 'Andheri'],
    'Pune': ['Mulshi', 'Haveli'],
    'Ahmedabad': ['Daskroi', 'Sanand'],
    'Surat': ['Choryasi', 'Ichhpur'],
  };

  @override
  void initState() {
    super.initState();
    _initializePermissionProvider();
    _loadFormData(); // Load the saved form data
    _loadClickedType();
  }

  Future<void> _loadClickedType() async {
    isClickedBy = await _storage.getClickedBy();
    debugPrint("clickBy--$isClickedBy");
  }

  // Fetch saved form data from DB
  Future<void> _loadFormData() async {
    setState(() {
      _isLoading = true;
    });

    feedbackData = await dbHelper.getFeedbackForm();

    debugPrint("feedbackdata $feedbackData");

    setState(() {
      _isLoading = false;
      if (feedbackData != null) {
        // Set state controller
        _stateController.text = feedbackData?.state ?? '';
        selectedState = feedbackData?.state; // Update selected state

        // Update districts based on selected state
        selectedDistricts = districts[selectedState] ?? [];

        // Set district controller
        _districtController.text = feedbackData?.district ?? '';
        selectedDistrict = feedbackData?.district; // Update selected district

        // Update blocks based on selected district
        selectedBlocks = blocks[selectedDistrict] ?? [];

        // Set block controller
        _blockController.text = feedbackData?.block ?? '';
        selectedBlock = feedbackData?.block; // Update selected block

        // Update roads based on selected block
        selectedRoads = roadNames[selectedBlock] ?? [];

        // Set road controller
        _roadNameController.text = feedbackData?.roadName ?? '';

        if(feedbackData?.roadName == "Enter Manually"){
          roadNameEnable = true;
        }

        debugPrint("_staticRoadNameController ${feedbackData?.staticRoadName}");

        // Set road controller
        _staticRoadNameController.text = feedbackData?.staticRoadName ?? '';

        // Set other controllers
        _categoryOfComplaintController.text =
            feedbackData?.categoryOfComplaint ?? '';
        _writeFeedbackController.text = feedbackData?.feedback ?? '';
      }
    });
  }

  // Save the form data to DB
  void _saveFormData() {
    String text = _stateController.text.toString();
    debugPrint("Save data$text");
    final feedbackFormData = FeedbackFormData(
      state: _stateController.text,
      district: _districtController.text,
      block: _blockController.text,
      roadName: _roadNameController.text,
      staticRoadName: _staticRoadNameController.text,
      categoryOfComplaint: _categoryOfComplaintController.text,
      feedback: _writeFeedbackController.text,
    );

    dbHelper.saveFeedbackForm(feedbackFormData);
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      body: Consumer<ImagePickerProvider>(
        builder: (context, imagePickerProvider, child) {
          return CustomBodyWithGradient(
            title: AppStrings.registerFeedback,
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
                            : previewForm(
                              imagePickerProvider,
                              permissionProvider,
                            ),
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

  Widget feedbackForm(
    ImagePickerProvider imagePickerProvider,
    PermissionProvider permissionProvider,
  ) {
    return Column(
      children: [
        SizedBox(
          height: DeviceSize.getScreenHeight(context) * 0.48, // Fixed height
          width: DeviceSize.getScreenWidth(context), // Fixed width
          child: permissionProvider.isLoading
              ? Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(), // Loading indicator
          )
              : CustomLocationWidget(
            labelText: AppStrings.confirmTheRoadLocation,
            isRequired: false,
            latitude: permissionProvider.latitude,
            longitude: permissionProvider.longitude,
            initialAddress: permissionProvider.address.toString(),
            isLoading: permissionProvider.isLoading,
            mapHeight: DeviceSize.getScreenHeight(context) * 0.25, // Same height as parent
            mapWidth: DeviceSize.getScreenWidth(context), // Same width as parent
            onRefresh: () async {
              await permissionProvider.fetchCurrentLocation();
            },
            onMapTap: (point) async {
              await permissionProvider.setLocation(
                point.latitude,
                point.longitude,
              );

              if(feedbackData!.state!.isEmpty){
                setState(() {
                  // debugPrint("state $state");

                  // Update text controllers with new values
                  _stateController.text = permissionProvider.state;
                  selectedState =  permissionProvider.state; // Update selectedState
                  selectedDistricts = districts[selectedState] ?? []; // Update districts based on new state
                  _districtController.text =  permissionProvider.district; // Set district controller
                  selectedBlocks = blocks[permissionProvider.district] ?? []; // Update blocks based on new district
                });

                // Optionally save form data if needed
                _saveFormData();
              }
            },
            onMapReady: () {
              if (feedbackData == null || feedbackData!.state!.isEmpty) {
                setState(() {
                  _stateController.text = permissionProvider.state;
                  selectedState = permissionProvider.state;
                  selectedDistricts = districts[selectedState] ?? [];
                  _districtController.text = permissionProvider.district;
                  selectedBlocks = blocks[permissionProvider.district] ?? [];
                });
                _saveFormData();
              }
            },
          ),
        ),

        const SizedBox(height: AppDimensions.di_20),

        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.uploadRoadImages,
            fontSize: AppDimensions.di_16,
            fontWeight: AppFontWeight.fontWeight600,
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
                _storage.setClickedBy(AppStrings.camera);
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
                _storage.setClickedBy(AppStrings.gallery);
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
              child: Column(mainAxisSize: MainAxisSize.min, children: []),
            )
            : SizedBox(
              height: DeviceSize.getScreenHeight(context) * 0.15,
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
                                child: Image.file(
                                  File(imageItem.imagePath),
                                  width: AppDimensions.di_100,
                                  height: AppDimensions.di_100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    () =>
                                        imagePickerProvider.deleteImage(index),
                                child: SvgPicture.asset(
                                  ImageAssetsPath.deleteImage,
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* SizedBox(height: AppDimensions.di_6),
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
                        ),*/
                      ],
                    ),
                  );
                },
              ),
            ),

        SizedBox(height: AppDimensions.di_5),

        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.enterRoadDetails,
            fontSize: AppDimensions.di_16,
            fontWeight: AppFontWeight.fontWeight600,
            color: AppColors.black,
          ),
        ),

        SizedBox(height: AppDimensions.di_5),

        FutureBuilder<List<String>>(
          future: fetchStates(), // Use the initialized future
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text(''));
              // return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  // State dropdown
                  CustomDropdownField(
                    hintText: "Please Select State",
                    textController: _stateController,
                    items: snapshot.data!,
                    dropdownHeight: 150,
                    isRequired: false,
                    onChanged: (value) async {
                      setState(() {
                        debugPrint("statedata $value");
                        selectedState = value;
                        selectedDistricts = districts[selectedState] ?? [];
                        selectedBlocks
                            .clear(); // Clear blocks when state changes
                        selectedRoads.clear(); // Clear roads when state changes
                        _districtController
                            .clear(); // Clear district controller
                        _blockController.clear(); // Clear block controller
                        _roadNameController.clear(); // Clear road controller
                        _staticRoadNameController.clear();
                        roadNameEnable = false;
                      });
                      _saveFormData();
                    },
                  ),

                  // District dropdown
                  CustomDropdownField(
                    hintText: "Please Select District",
                    textController: _districtController,
                    items: selectedDistricts.isEmpty ? [''] : selectedDistricts,
                    dropdownHeight: 150,
                    isRequired: false,
                    onChanged: (value) async {
                      setState(() {
                        selectedBlocks = blocks[value] ?? [];
                        selectedRoads.clear(); // Clear roads when district changes
                        _blockController.clear();
                        _roadNameController
                            .clear(); // Clear the road controller when district changes
                        _staticRoadNameController.clear();
                        roadNameEnable = false;
                      });
                      _saveFormData();
                    },
                  ),

                  // Block dropdown
                  CustomDropdownField(
                    hintText: "Please Select Block",
                    textController: _blockController,
                    items: selectedBlocks.isEmpty ? [''] : selectedBlocks,
                    dropdownHeight: 150,
                    isRequired: false,
                    onChanged: (value) async {
                      setState(() {
                        selectedRoads = roadNames[value] ?? [];
                        _roadNameController
                            .clear(); // Clear road controller when block changes
                        _staticRoadNameController.clear();
                        roadNameEnable = false;
                      });
                      _saveFormData();
                    },
                  ),

                  // Road dropdown
                  CustomDropdownField(
                    hintText: "Please Select Road Name",
                    textController: _roadNameController,
                    items: selectedRoads.isEmpty ? [''] : selectedRoads,
                    dropdownHeight: 150,
                    isRequired: false,
                    onChanged: (value) async {
                      setState(() {
                        if("Enter Manually"!= value){
                          _saveFormData();
                          roadNameEnable = false;
                          _staticRoadNameController.clear();
                        }
                        else{
                          roadNameEnable = true;
                        }
                      });
                    },
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),

        CustomTextField(
          editable: roadNameEnable,
          onChanged: (text) => _saveFormData(),
          label: AppStrings.enterRoadName,
          controller: _staticRoadNameController,
          keyboardType: TextInputType.text,
          maxLines: 1,
          fontSize: AppDimensions.di_16,
          validator: null,
          isRequired: false,
          labelText: '',
        ),

        CustomDropdownField(
          onChanged: (text) => _saveFormData(),
          hintText: AppStrings.selectCategoryOfComplaint,
          textController: _categoryOfComplaintController,
          items: complaints,
          dropdownHeight: AppDimensions.di_200,
          isRequired: false,
        ),

        CustomTextField(
          onChanged: (text) => _saveFormData(),
          labelText: AppStrings.feedback,
          label: AppStrings.writeYourFeedback,
          controller: _writeFeedbackController,
          keyboardType: TextInputType.text,
          maxLines: 4,
          fontSize: AppDimensions.di_16,
          maxLength: 200,
          validator: null,
          isRequired: false,
        ),

        Align(
          alignment: Alignment.centerRight,
          child: CustomButton(
            text: AppStrings.preview,
            onPressed: () async {
              if (imagePickerProvider.imageFiles.isEmpty) {
                showToast(AppStrings.pleaseSelectImage);
              } else if (_stateController.text.isEmpty) {
                showToast(AppStrings.pleaseSelectState);
              } else if (_districtController.text.isEmpty) {
                showToast(AppStrings.pleaseSelectDistrict);
              } else if (_categoryOfComplaintController.text.isEmpty) {
                showToast(AppStrings.pleaseSelectComplaint);
              } else if (_writeFeedbackController.text.isEmpty) {
                showToast(AppStrings.pleaseWriteFeedback);
              } else {
                setState(() {
                  _showFeedbackForm = false;
                });
              }
            },
            textColor: AppColors.whiteColor,
            backgroundColor: AppColors.blueGradientColor1,
            fontSize: AppDimensions.di_18,
            padding: EdgeInsets.symmetric(
              vertical: AppDimensions.di_6,
              horizontal: AppDimensions.di_15,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.di_100),
            buttonHeight: AppDimensions.di_40,
          ),
        ),
      ],
    );
  }

  Widget previewForm(
    ImagePickerProvider imagePickerProvider,
    PermissionProvider permissionProvider,
  ) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.roadLocation,
            fontSize: AppDimensions.di_16,
            color: AppColors.black,
            fontWeight: AppFontWeight.fontWeight600,
          ),
        ),
        SizedBox(height: 5),

        CustomTextField(
          labelText: AppStrings.feedback,
          label: permissionProvider.address.toString(),
          controller: _locationController,
          keyboardType: TextInputType.name,
          maxLines: 1,
          maxLength: 30,
          validator: null,
          editable: false,
          isRequired: false,
          fontSize: AppDimensions.di_15,
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.roadImages,
            fontSize: AppDimensions.di_16,
            color: AppColors.black,
            fontWeight: AppFontWeight.fontWeight600,
          ),
        ),
        SizedBox(height: 10),

        imagePickerProvider.imageFiles.isEmpty
            ? const Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: []),
            )
            : SizedBox(
              height: DeviceSize.getScreenHeight(context) * 0.15,
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
                                File(imageItem.imagePath),
                                width: AppDimensions.di_100,
                                height: AppDimensions.di_100,
                                fit: BoxFit.cover,
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
            fontWeight: AppFontWeight.fontWeight600,
          ),
        ),

        SizedBox(height: 5),

        Container(
          color: AppColors.textFieldBorderColor.withAlpha(12),
          child: Table(
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
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextWidget(
                      text:
                          _stateController.text.isEmpty
                              ? "--"
                              : _stateController.text,
                      fontSize: AppDimensions.di_14,
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight500,
                    ),
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
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextWidget(
                      text:
                          _districtController.text.isEmpty
                              ? "--"
                              : _districtController.text,
                      fontSize: AppDimensions.di_14,
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight500,
                    ),
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
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextWidget(
                      text:
                          _blockController.text.isEmpty
                              ? "--"
                              : _blockController.text,
                      fontSize: AppDimensions.di_14,
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight500,
                    ),
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
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextWidget(
                      text:
                          _roadNameController.text.isEmpty
                              ? "--"
                              : _roadNameController.text,
                      fontSize: AppDimensions.di_14,
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight500,
                    ),
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
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextWidget(
                      text:
                          _categoryOfComplaintController.text.isEmpty
                              ? "--"
                              : _categoryOfComplaintController.text,
                      fontSize: AppDimensions.di_14,
                      color: AppColors.black.withAlpha(95),
                      fontWeight: AppFontWeight.fontWeight500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.textFieldBorderColor.withAlpha(12),
          child: Table(
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
                          color: AppColors.black.withAlpha(95),
                          fontWeight: AppFontWeight.fontWeight600,
                        ),

                        CustomTextWidget(
                          text:
                              _writeFeedbackController.text.isEmpty
                                  ? "--"
                                  : _writeFeedbackController.text,
                          fontSize: AppDimensions.di_14,
                          color: AppColors.black.withAlpha(95),
                          maxlines: 5,
                          fontWeight: AppFontWeight.fontWeight500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                backgroundColor: AppColors.blueGradientColor1,
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
                onPressed: () async {
                  /* Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                      const SubmittedFeedbackScree(),
                    ),
                  );*/
                  _showSaveConfirmationDialog(context, imagePickerProvider);
                },
                textColor: AppColors.whiteColor,
                backgroundColor: AppColors.blueGradientColor1,
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

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomTextWidget(
          text: message,
          fontSize: AppDimensions.di_16,
          color: AppColors.whiteColor,
        ),
        backgroundColor: Colors.red,
        // Use orange or yellow for warnings
        duration: Duration(seconds: 3), // Duration the SnackBar is visible
      ),
    );
  }

  void _showSaveConfirmationDialog(
    BuildContext context,
    ImagePickerProvider imagePickerProvider,
  ) {
    showCustomConfirmationDialog(
      context: context,
      title: 'Are you sure?',
      content: 'Do you really want to submit the feedback?',
      icon: Icons.help_outline,
      backgroundColor: Colors.blue,
      iconColor: Colors.blue,
      onYesPressed: () async {
        imagePickerProvider.clearImages();
        dbHelper.clearFeedbackTable();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }

  Future<List<String>> fetchStates() async {
    // Simulate a network call or database fetch
    return [
      'Madhya Pradesh',
      'Uttar Pradesh',
      'Maharashtra',
      'Gujarat',
    ]; // Replace with actual data fetching logic
  }

  Future<void> _initializePermissionProvider() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final imagePickerProvider = Provider.of<ImagePickerProvider>(
        context,
        listen: false,
      );

      await imagePickerProvider.loadImages();
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
