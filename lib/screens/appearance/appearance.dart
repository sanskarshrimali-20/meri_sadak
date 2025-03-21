import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_dialog_button.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_image_path.dart';
import '../../providerData/theme_provider.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../utils/localization_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/drawer_widget.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreen();
}

class _AppearanceScreen extends State<AppearanceScreen> {

  bool languageEnglish = false;
  bool languageHindi = false;

  @override
  void initState() {
    saveLocalizationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    if(localizationProvider.locale == Locale('en', 'US')){
      languageEnglish =true;
      languageHindi = false;
    }
    else{
      languageEnglish =false;
      languageHindi = true;
    }

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.whiteColor
          : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title: localizationProvider.localizedStrings['appearance'] ?? "Appearance",
        childHeight: DeviceSize.getScreenHeight(context) * 0.3,
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

            padding: EdgeInsets.all(AppDimensions.di_5),

            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(height: AppDimensions.di_15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),  // Margin from the start
                        child: SvgPicture.asset(ImageAssetsPath.appearanceIcon),
                      ),
                      SizedBox(width: AppDimensions.di_18),
                      CustomTextWidget(
                        text: localizationProvider.localizedStrings['theme_color'] ?? "Dark and Light Mode", fontSize: AppDimensions.di_18,
                        color: themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                      ),
                      Spacer(),
                       Transform.scale(
                          scale: 0.8,  // Adjust the size of the switch
                          child: Switch(
                            value: themeProvider.themeMode == ThemeMode.dark,
                            onChanged: (value) {
                              themeProvider.toggleTheme(); // Toggle the theme on switch change
                            },
                            activeColor: AppColors.whiteColor,  // Color of the thumb when active
                            inactiveThumbColor: Colors.white,  // Color of the thumb when inactive
                            activeTrackColor: AppColors.blueGradientColor1,  // Color of the track when active
                            inactiveTrackColor: Colors.grey,
                          ),
                        ),
                    ],
                  ),

                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: localizationProvider.localizedStrings['font_size'] ?? "Font Size",
                    icon: ImageAssetsPath.fontSize,
                    textColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    iconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    suffixIconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    onClick: () {

                    },
                  ),
                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    title: localizationProvider.localizedStrings['language'] ?? "Language",
                    icon: ImageAssetsPath.language,
                    textColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    iconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    suffixIconColor: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.black
                        : AppColors.whiteColor,
                    onClick: () {

                     /* CustomSelectionDialog(
                        title: "Select Language",
                        titleVisibility: false,
                        content: AppStrings.selectLanguagePre,
                        icon: "assets/icons/language_icon.svg",
                        iconVisibility: false,
                        buttonLabels: [ localizationProvider.localizedStrings['english'] ?? "English",
                          localizationProvider.localizedStrings['hindi'] ?? "Hindi" ],
                        onButtonPressed: [
                              () {
                            localizationProvider.setLocale(Locale('en', 'US'));
                            Navigator.pop(context);
                          },
                              () {
                            localizationProvider.setLocale(Locale('hi', 'IN'));
                            Navigator.pop(context);
                          }
                        ], isButtonActive: [languageEnglish, languageHindi]
                      );*/

                      _showCustomSelectionDialog(
                        title: "Select Language",
                        titleVisibility: false,
                        content: AppStrings.selectLanguagePre,
                        icon: "assets/icons/language_icon.svg",
                        iconVisibility: false,
                        buttonLabels: [ localizationProvider.localizedStrings['english'] ?? "English",
                          localizationProvider.localizedStrings['hindi'] ?? "Hindi" ],
                        onButtonPressed: [
                              () {
                            localizationProvider.setLocale(Locale('en', 'US'));
                            Navigator.pop(context);
                          },
                              () {
                                localizationProvider.setLocale(Locale('hi', 'IN'));
                            Navigator.pop(context);
                          }
                        ], isButtonActive: [languageEnglish, languageHindi], context: context,
                      );

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCustomSelectionDialog({
    required BuildContext context,
    String? title, // Optional title
    String? icon, // Optional icon (if you want to show it)
    String? content, // Optional content (if you want custom content)
    List<String>? buttonLabels, // List of button labels for 1 to 3 buttons
    required List<VoidCallback> onButtonPressed, // List of callback functions for buttons
    required List<bool> isButtonActive, // List of boolean values to determine button activeness
    bool titleVisibility = false, // To show or hide the title
    bool iconVisibility = false, // To show or hide buttons
  }) async
  {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          contentPadding: EdgeInsets.zero, // Remove default padding from the AlertDialog
          content: Consumer<LocalizationProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0), // Custom padding for the content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Allow the Column to take as little space as possible
                  children: [
                    // Show the icon if iconVisibility is true
                    if (iconVisibility && icon != null)
                      ClipRect(
                        child: SvgPicture.asset(icon), // Show the icon
                      ),

                    // Show title if titleVisibility is true
                    if (titleVisibility && title != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomTextWidget(
                          text: title,
                          fontSize: AppDimensions.di_15,
                          color: AppColors.black.withAlpha(150),
                          fontWeight: AppFontWeight.fontWeight600,
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // Show content if available
                    if (content != null)
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomTextWidget(
                          text: content,
                          fontSize: AppDimensions.di_15,
                          color: AppColors.black.withAlpha(200),
                          fontWeight: AppFontWeight.fontWeight500,
                          textAlign: TextAlign.center,
                        ),
                      ),

                    SizedBox(height: AppDimensions.di_5), // Space between content and buttons

                    // Conditionally show buttons based on the button count in `buttonLabels`
                    if (buttonLabels != null && buttonLabels.isNotEmpty)
                      for (int i = 0; i < buttonLabels.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                          child: CustomDialogButton(
                            text: buttonLabels[i],
                            fontSize: AppDimensions.di_15,
                            onClick:  onButtonPressed[i], // If button is active, assign onClick callback
                            isActive: isButtonActive[i], // Pass the button active state
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }



  void saveLocalizationData() async {
    final dbHelper = DatabaseHelper();

    // English localization data
    Map<String, String> enLocalization = {
      "theme_color": "Dark and Light Mode",
      "name": "Sanskar Shrimali",
      "language": "Language",
      "font_size": "Font Size",
      "settings": "Settings",
      "general_settings": "General Settings",
      "appearance":"Appearance",
      "english":"English",
      "hindi":"Hindi"

      // other English translations
    };

    // Hindi localization data
    Map<String, String> hiLocalization = {
      "theme_color": "डार्क और लाइट मोड",
      "language": "भाषा",
      "font_size": "फ़ॉन्ट आकार",
      "settings": "सेटिंग्स",
      "name": "संस्कार",
      "general_settings": "सामान्य सेटिंग्स",
      "appearance":"स्वरूप",
      "english":"अंग्रेज़ी",
      "hindi":"हिंदी"
      // other Hindi translations
    };

    // Save English and Hindi data
    await dbHelper.insertLocalization('en', enLocalization);
    await dbHelper.insertLocalization('hi', hiLocalization);
  }
}
