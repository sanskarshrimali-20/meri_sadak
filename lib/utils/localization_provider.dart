import 'package:flutter/cupertino.dart';
import 'package:meri_sadak/services/LocalStorageService/local_storage.dart';
import 'app_localize.dart';

class LocalizationProvider with ChangeNotifier {
  Locale _locale = Locale('en', 'US');
  Map<String, String> _localizedStrings = {};
  final _storage = LocalSecureStorage(); // Secure storage instance

  Locale get locale => _locale;
  Map<String, String> get localizedStrings => _localizedStrings;

  Future<void> setLocale(Locale locale) async {
    _locale = locale;

    if (locale == Locale('en', 'US')) {
      await _storage.setLanguage('en');
    } else if (locale == Locale('hi', 'IN')) {
      await _storage.setLanguage('hi');
    }

    // Load the localization data and assign the localized strings to _localizedStrings
    AppLocalization appLocalization = await AppLocalization.load(locale.languageCode);
    _localizedStrings = appLocalization.localizedStrings;

    notifyListeners();
  }

  Future<void> initLocale() async {
    final storedLanguage = await _storage.getLanguage();

    if (storedLanguage == 'en') {
      await setLocale(Locale('en', 'US'));

    } else if (storedLanguage == 'hi') {
      await setLocale(Locale('hi', 'IN'));

    } else {
      // Default to English if no language is stored
      await setLocale(Locale('en', 'US'));
    }
  }
}
