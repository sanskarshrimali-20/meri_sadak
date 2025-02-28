import 'package:flutter/cupertino.dart';
import 'app_localize.dart';

class LocalizationProvider with ChangeNotifier {
  Locale _locale = Locale('en', 'US');
  Map<String, String> _localizedStrings = {};

  Locale get locale => _locale;
  Map<String, String> get localizedStrings => _localizedStrings;

  // Method to set the locale and load the corresponding language data
  Future<void> setLocale(Locale locale) async {
    _locale = locale;

    // Load the localization data and assign the localized strings to _localizedStrings
    AppLocalization appLocalization = await AppLocalization.load(locale.languageCode);
    _localizedStrings = appLocalization.localizedStrings;

    notifyListeners();
  }
}
