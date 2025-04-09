import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';
import '../../utils/device_size.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/custom_text_field.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final LocalSecureStorage _localStorage = LocalSecureStorage();
  final dbHelper = DatabaseHelper();
  String name = "";
  String phone = "";
  String email = "";
  String char = "";
  String gender = "";
  String address = "";

  final TextEditingController _genderCategoryController =
  TextEditingController();
  final TextEditingController _addressController =
  TextEditingController();
  bool isEditing = false; // Initialize as false to show profile by default
  final List<String> genderSelection = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _initializeUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    debugPrint('isEditing called from top $isEditing');

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: DeviceSize.getScreenHeight(context),
          child: CustomBodyWithGradient(
            title: AppStrings.myProfile,
            childHeight: isEditing
            ? DeviceSize.getScreenHeight(context) * 0.85 // If in edit mode
               : (address.isEmpty && gender.isEmpty)
                ? DeviceSize.getScreenHeight(context) * 0.6  // If both are empty in view mode
                : (address.isNotEmpty && gender.isEmpty) || (address.isEmpty && gender.isNotEmpty)
                ? DeviceSize.getScreenHeight(context) * 0.8  // If one is empty in view mode
                : DeviceSize.getScreenHeight(context) * 0.8  ,// If both are non-empty in view mode
        
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
                padding: EdgeInsets.all(AppDimensions.di_18),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimensions.di_10),
                      Center(
                        child: Container(
                          width: 90, // Width of the circle (2 * radius)
                          height: 90, // Height of the circle (2 * radius)
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Make the container a circle
                            border: Border.all(
                              color: AppColors.toastBgColorGreen, // Color of the border
                              width: 2, // Stroke width
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50, // Radius of the avatar (half of the container size)
                            backgroundColor: AppColors.whiteColor, // Background color for the circle
                            child: Text(
                              char, // First character of the name
                              style: TextStyle(
                                color: AppColors.blueGradientColor1, // Color of the text
                                fontSize: AppDimensions.di_50, // Text size
                                fontWeight: AppFontWeight.fontWeight600, // Text weight
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.di_30),
                      // Show the appropriate widget based on the isEditing state
                      isEditing
                          ? buildProfileDetails(name, phone, email, gender, address, themeProvider)
                          : profileDetails(name, phone, email, gender, address, themeProvider),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget profileDetails(String name, String phone, String email, String gender, String address,ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: '${AppStrings.name} : $name', fontSize: AppDimensions.di_18,
          fontWeight: AppFontWeight.fontWeight600,
          color: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
        ),
        Divider(
          color: Colors.grey.withAlpha(60), // Line color
          thickness: AppDimensions.di_1, // Line thickness
          indent: AppDimensions.di_1, // Space from the left
          endIndent: AppDimensions.di_1, // Space from the right
        ),
        CustomTextWidget(
          text: '${AppStrings.phoneNoO} : $phone', fontSize: AppDimensions.di_18,
          fontWeight: AppFontWeight.fontWeight600,
          color: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
        ),
        Divider(
          color: Colors.grey.withAlpha(60), // Line color
          thickness: AppDimensions.di_1, // Line thickness
          indent: AppDimensions.di_1, // Space from the left
          endIndent: AppDimensions.di_1, // Space from the right
        ),
        CustomTextWidget(
          text: '${AppStrings.emailId} : $email', fontSize: AppDimensions.di_18,
          fontWeight: AppFontWeight.fontWeight600,
          color: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
        ),
        gender.isNotEmpty
            ? Divider(
          color: Colors.grey.withAlpha(60), // Line color
          thickness: AppDimensions.di_1, // Line thickness
          indent: AppDimensions.di_1, // Space from the left
          endIndent: AppDimensions.di_1, // Space from the right
        )
            : const SizedBox.shrink(),
        gender.isNotEmpty
            ? CustomTextWidget(
          text: '${AppStrings.gender} : $gender', fontSize: AppDimensions.di_18,
          fontWeight: AppFontWeight.fontWeight600,
          color: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
        )
            : const SizedBox.shrink(),
        address.isNotEmpty
            ? Divider(
          color: Colors.grey.withAlpha(60), // Line color
          thickness: AppDimensions.di_1, // Line thickness
          indent: AppDimensions.di_1, // Space from the left
          endIndent: AppDimensions.di_1, // Space from the right
        )
            : const SizedBox.shrink(),

        address.isNotEmpty?
        CustomTextWidget(
          text: '${AppStrings.address} :', fontSize: AppDimensions.di_18,
          fontWeight: AppFontWeight.fontWeight600,
          color: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
        ): const SizedBox.shrink(),
        SizedBox(height: AppDimensions.di_2),
        address.isNotEmpty
            ? CustomTextWidget(
          text: address, fontSize: AppDimensions.di_18,
          fontWeight: AppFontWeight.fontWeight600,
          color: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
        )
            : const SizedBox.shrink(),
        SizedBox(height: AppDimensions.di_20),
        Align(
          alignment: Alignment.center,
          child: CustomButton(
            text: AppStrings.edit,
            onPressed: () async {
                setState(() {
                  isEditing = true;
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
            buttonHeight: AppDimensions.di_40,
          ),
        ),
      ],
    );
  }

  Widget buildProfileDetails(String name, String phone, String email, String gender, String address, ThemeProvider themeProvider) {
    debugPrint('buildProfileDetails called');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppDimensions.di_10),
        CustomContainerText(
          label: name,
          fontSize: AppDimensions.di_17,
          textColor: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black.withAlpha(200)
              : AppColors.whiteColor.withAlpha(200),
          boxBgColor: themeProvider.themeMode == ThemeMode.light
              ? AppColors.colorF6F6F6
              : AppColors.selectImageColor.withAlpha(100),
        ),
        SizedBox(height: AppDimensions.di_10),
        CustomContainerText(
          label: phone,
          fontSize: AppDimensions.di_17,
          textColor: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black.withAlpha(200)
              : AppColors.whiteColor.withAlpha(200),
          boxBgColor: themeProvider.themeMode == ThemeMode.light
              ? AppColors.colorF6F6F6
              : AppColors.selectImageColor.withAlpha(100),
        ),
        SizedBox(height: AppDimensions.di_10),
        CustomContainerText(
          label: email,
          fontSize: AppDimensions.di_17,
          textColor: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black.withAlpha(200)
              : AppColors.whiteColor.withAlpha(200),
          boxBgColor: themeProvider.themeMode == ThemeMode.light
              ? AppColors.colorF6F6F6
              : AppColors.selectImageColor.withAlpha(100),
        ),
        SizedBox(height: AppDimensions.di_10),
        CustomDropdownField(
          hintText: AppStrings.selectGender,
          textController: _genderCategoryController,
          items: genderSelection,
          dropdownBgColor:
          themeProvider.themeMode == ThemeMode.light
              ? Colors.grey.shade200
              : AppColors.textBoxDarkModeColor,
          textColor:
          themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
          boxBgColor:
          themeProvider.themeMode == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.textBoxDarkModeColor,
          dropdownHeight: AppDimensions.di_150,
          isRequired: false,
        ),
        CustomTextField(
          editable: true,
          boxBgEnableColor: AppColors.app_bg_color,
          textColor: themeProvider.themeMode == ThemeMode.light
              ? AppColors.black
              : AppColors.whiteColor,
          boxBgColor:
          themeProvider.themeMode == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.textBoxDarkModeColor,
          label: AppStrings.enterAddress,
          controller: _addressController,
          keyboardType: TextInputType.text,
          maxLines: 1,
          fontSize: AppDimensions.di_16,
          validator: null,
          isRequired: false,
          labelText: '',
        ),
        SizedBox(height: AppDimensions.di_10),
        Align(
          alignment: Alignment.center,
          child: CustomButton(
            text: AppStrings.submit,
            onPressed: () async {
              setState(() {
                _updateUserDetails();
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
            buttonHeight: AppDimensions.di_40,
          ),
        ),
      ],
    );
  }

  Future<void> _updateUserDetails() async {
    String? user = await _localStorage.getLoginUser();

    // Get user profile details
    final profile = await dbHelper.getSignupDetails(user!);

    // Ensure profile is not null before trying to update
    if (profile != null) {
      // Create a mutable map from the profile (QueryRow)
      Map<String, dynamic> updatedProfile = Map.from(profile);

      // Update the necessary fields
      updatedProfile['gender'] = _genderCategoryController.text;
      updatedProfile['address'] = _addressController.text;

      // Update the database with the modified profile
      await dbHelper.updateSignupDetails(updatedProfile, user);
      debugPrint("setDetails");

      // Fetch updated profile details
      final getUpdateProfile = await dbHelper.getSignupDetails(user);
      debugPrint("getDetails ${getUpdateProfile?['fullName'] ?? 'No Name'}");
      debugPrint("getDetails gender ${getUpdateProfile?['gender'] ?? 'No Name'}");

      // Update UI state
      setState(() {
        name = getUpdateProfile?['fullName'] ?? 'No Name';
        phone = getUpdateProfile?['phoneNo'] ?? 'No Name';
        email = getUpdateProfile?['email'] ?? 'No Name';
        char = name.isNotEmpty ? name[0] : '';
        gender = getUpdateProfile?['gender'] ?? 'No Name';
        address = getUpdateProfile?['address'] ?? 'No Name';
        isEditing = false; // Switch back to view mode
      });
    } else {
      debugPrint("Profile not found for user: $user");
    }
  }


  Future<void> _initializeUserDetails() async {
    String? user = await _localStorage.getLoginUser();
    final profile = await dbHelper.getSignupDetails(user!);

    setState(() {
      name = profile?['fullName'] ?? 'No Name';
      phone = profile?['phoneNo'] ?? 'No Name';
      email = profile?['email'] ?? 'No Name';
      char = name.isNotEmpty ? name[0] : '';
      gender = profile?['gender'] ?? 'No Name';
      address = profile?['address'] ?? 'No Name';
      _genderCategoryController.text = profile?['gender'] ?? 'No Name';
      _addressController.text = profile?['address'] ?? 'No Name';
    });
  }
}
