import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/utils/fontsize_provider.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:meri_sadak/widgets/selection_dialog.dart';
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

  bool fontSmall = false;
  bool fontRegular = false;
  bool fontLarge = false;

  @override
  void initState() {
    saveLocalizationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    if (localizationProvider.locale == Locale('en', 'US')) {
      languageEnglish = true;
      languageHindi = false;
    } else {
      languageEnglish = false;
      languageHindi = true;
    }

    if (fontSizeProvider.fontSize == 14.0) {
      fontSmall = true;
      fontRegular = false;
      fontLarge = false;
    } else if(fontSizeProvider.fontSize == 18.0 ) {
      fontSmall = false;
      fontRegular = true;
      fontLarge = false;
    } else{
      fontSmall = false;
      fontRegular = false;
      fontLarge = true;
    }

    return Scaffold(
      backgroundColor:
          themeProvider.themeMode == ThemeMode.light
              ? AppColors.bgColorGainsBoro
              : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title:
            localizationProvider.localizedStrings['appearance'] ?? "Appearance",
        childHeight: DeviceSize.getScreenHeight(context) * 0.29,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.di_5),
          child: Container(
            decoration: BoxDecoration(
              color:
                  themeProvider.themeMode == ThemeMode.light
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
                        padding: const EdgeInsets.only(left: 12.0),
                        child: SvgPicture.asset(
                          ImageAssetsPath.appearanceIcon,
                          color: themeProvider.themeMode == ThemeMode.light
                              ? AppColors.black
                              : AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(width: AppDimensions.di_14),
                      Expanded(
                        // This allows the text to take available space
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                          child: CustomTextWidget(
                            text: localizationProvider.localizedStrings['theme_color'] ??
                                "Dark and Light Mode",
                            fontSize: fontSizeProvider.fontSize,
                            fontWeight: AppFontWeight.fontWeight500,
                            color: themeProvider.themeMode == ThemeMode.light
                                ? AppColors.black
                                : AppColors.whiteColor,
                            textOverflow: TextOverflow.visible,  // Allow text to be visible without truncation
                            maxlines: 1,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.8, // Adjust the size of the switch
                        child: Switch(
                          value: themeProvider.themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            themeProvider.toggleTheme(); // Toggle the theme on switch change
                          },
                          activeColor: AppColors.whiteColor,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: AppColors.blueGradientColor1,
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
                    fontSize: fontSizeProvider.fontSize,
                    title:
                        localizationProvider.localizedStrings['font_size'] ??
                        "Font Size",
                    icon: ImageAssetsPath.fontSize,
                    textColor:
                        themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                    iconColor:
                        themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                    suffixIconColor:
                        themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                    onClick: () {
                      showCustomSelectionDialog(
                        title: "Select Language",
                        titleVisibility: false,
                        content: AppStrings.chooseFont,
                        icon: "assets/icons/language_icon.svg",
                        iconVisibility: false,
                        buttonLabels: [
                          localizationProvider.localizedStrings['small'] ??
                              "Small",
                          localizationProvider.localizedStrings['regular'] ??
                              "Regular",
                          localizationProvider.localizedStrings['large'] ??
                              "Large",
                        ],
                        onButtonPressed: [
                          () {
                            fontSizeProvider.setSmall();
                            Navigator.pop(context);
                          },
                          () {
                            fontSizeProvider.setRegular();
                            Navigator.pop(context);
                          },
                          () {
                            fontSizeProvider.setLarge();
                            Navigator.pop(context);
                          },
                        ],
                        isButtonActive: [fontSmall, fontRegular, fontLarge],
                        context: context,
                        dialogHeight: 280,
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey.withAlpha(60), // Line color
                    thickness: AppDimensions.di_1, // Line thickness
                    indent: AppDimensions.di_10, // Space from the left
                    endIndent: AppDimensions.di_10, // Space from the right
                  ),

                  customDrawerWidget(
                    fontSize :fontSizeProvider.fontSize,
                    title:
                        localizationProvider.localizedStrings['language'] ??
                        "Language",
                    icon: ImageAssetsPath.language,
                    textColor:
                        themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                    iconColor:
                        themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                    suffixIconColor:
                        themeProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.whiteColor,
                    onClick: () {
                      showCustomSelectionDialog(
                        title: "Select Language",
                        titleVisibility: false,
                        content: localizationProvider.localizedStrings['select_language'] ??
                            AppStrings.selectLanguagePre,
                        icon: "assets/icons/language_icon.svg",
                        iconVisibility: false,
                        buttonLabels: [
                          localizationProvider.localizedStrings['english'] ??
                              "English",
                          localizationProvider.localizedStrings['hindi'] ??
                              "Hindi",
                        ],
                        onButtonPressed: [
                          () {
                            localizationProvider.setLocale(Locale('en', 'US'));
                            Navigator.pop(context);
                          },
                          () {
                            localizationProvider.setLocale(Locale('hi', 'IN'));
                            Navigator.pop(context);
                          },
                        ],
                        isButtonActive: [languageEnglish, languageHindi],
                        context: context,
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
      "appearance": "Appearance",
      "english": "English",
      "hindi": "Hindi",
      "yes": "Yes",
      "no": "No",
      "small": "Small",
      "regular": "Regular",
      "large": "Large",
      "select_language": "Select your preferred language",
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
      "appearance": "स्वरूप",
      "english": "अंग्रेज़ी",
      "hindi": "हिंदी",
      "yes": "हाँ",
      "no": "नहीं",
      "small": "छोटा",
      "regular": "नियमित",
      "large": "बड़ा",
      "select_language": "अपनी भाषा चुनें",
      // other Hindi translations
    };

    // Save English and Hindi data
    await dbHelper.insertLocalization('en', enLocalization);
    await dbHelper.insertLocalization('hi', hiLocalization);
  }
}
