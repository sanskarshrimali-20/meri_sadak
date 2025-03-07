import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../utils/localization_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_icon_button.dart';
import '../passwordChange/forgot_reset_password_screen.dart';

class SettingScreen extends StatefulWidget {
  final Map<String, dynamic>? userProfile;

  const SettingScreen({super.key, this.userProfile});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  void initState() {
    saveLocalizationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyHundred,
        appBar: CustomAppBar(
          title: AppStrings.settings,
          leadingIcon: ImageAssetsPath.backArrow,
        ),
        body: SingleChildScrollView(
        child: Column(
        children: [

          CustomButton(
            text: AppStrings.selectLanguage,
            onPressed: () async {
              _showLanguageSelectionDialog();
            },
            textColor: AppColors.whiteColor,
            backgroundColor: AppColors.color_E77728,
            fontSize: AppDimensions.di_18,
            padding:
            EdgeInsets.symmetric(vertical: AppDimensions.di_6, horizontal: AppDimensions.di_15),
            borderRadius: BorderRadius.circular(AppDimensions.di_100),
          ),

          SizedBox(height: 30,),

          CustomButton(
            text: AppStrings.resetPassword,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                      ForgotResetPasswordScreen(type: AppStrings.resetPassword), // Pass the profile data
                ),
              );            },
            textColor: AppColors.whiteColor,
            backgroundColor: AppColors.color_E77728,
            fontSize: AppDimensions.di_18,
            padding:
            EdgeInsets.symmetric(vertical: AppDimensions.di_6, horizontal: AppDimensions.di_15),
            borderRadius: BorderRadius.circular(AppDimensions.di_100),
          ),



        ]))
    );
  }

  Future<void> _showLanguageSelectionDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: const Text('Choose Language'), actions: [
            Consumer<LocalizationProvider>(
                builder: (context, provider, child) {
                  return Container(
                      child: Row(
                        children: [
                          CustomTextIconButton(
                            icon: Icons.language,
                            label: 'English',
                            onPressed: () {
                              provider.setLocale(Locale('en', 'US'));
                              Navigator.pop(context); // Close the dialog
                            },
                            backgroundColor: Colors.blue[50],
                            textColor: Colors.blue,
                            iconColor: Colors.blue,
                          ),
                          Spacer(),
                          CustomTextIconButton(
                            icon: Icons.temple_hindu,
                            label: 'Hindi',
                            onPressed: () {
                              provider.setLocale(Locale('hi', 'IN'));
                              Navigator.pop(context); // Close the dialog
                            },
                            backgroundColor: Colors.blue[50],
                            textColor: Colors.blue,
                            iconColor: Colors.blue,
                          )
                        ],
                      ));
                })
          ]);
        });
  }

  void saveLocalizationData() async {
    final dbHelper = DatabaseHelper();

    // English localization data
    Map<String, String> enLocalization = {
      "settings": "Settings",
      "name": "Sanskar Shrimali",
      "general_settings": "General Settings",
      // other English translations
    };

    // Hindi localization data
    Map<String, String> hiLocalization = {
      "settings": "सेटिंग्स",
      "name": "संस्कार",
      "general_settings": "सामान्य सेटिंग्स",
      // other Hindi translations
    };

    // Save English and Hindi data
    await dbHelper.insertLocalization('en', enLocalization);
    await dbHelper.insertLocalization('hi', hiLocalization);
  }

}