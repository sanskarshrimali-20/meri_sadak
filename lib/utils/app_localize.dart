import '../services/DatabaseHelper/database_helper.dart';

class AppLocalization {
  final Map<String, String> _localizedStrings;

  AppLocalization(this._localizedStrings);

  // Static method to load localization data based on language code
  static Future<AppLocalization> load(String languageCode) async {
    Map<String, String> localizedStrings = await fetchLocalizationData(languageCode);
    return AppLocalization(localizedStrings);
  }

  // Static method to simulate fetching localization data based on the language code
  static Future<Map<String, String>> fetchLocalizationData(String languageCode) async {
    final dbHelper = DatabaseHelper();
    Map<String, String>? localizedStrings = await dbHelper.getLocalization(languageCode);

    if (localizedStrings != null) {
      return localizedStrings;
    } else {
      return {};
    }
  }

  // Get the localized strings (as Map)
  Map<String, String> get localizedStrings => _localizedStrings;
}
