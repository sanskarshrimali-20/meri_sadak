import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../DatabaseHelper/database_helper.dart';

class LocalSecureStorage {

  final _storage = const FlutterSecureStorage();

  Future<void> setLoggingState(String isLoggedIn) async {
    if (kDebugMode) {
      log("Setting isLoggedIn as $isLoggedIn");
    }
    await _storage.write(
        key: 'isLoggedIn', value: isLoggedIn); // Save login state

    if (kDebugMode) {
      log("set isLoggedIn as $isLoggedIn");
    }
  }

  Future<String?> getLoggingState() async {
    String? isLoggedIn = await _storage.read(key: 'isLoggedIn');
    return isLoggedIn; // Return the login state
  }

  Future<void> setUserName(String username) async {
    await _storage.write(key: 'username', value: username); // Save username
  }

  Future<String?> getUserName() async {
    String? loggedInValue = await _storage.read(key: 'username');
    return loggedInValue; // Return the username
  }

  Future<void> setAccessToken(String accessToken) async {
    await _storage.write(
        key: 'accessToken', value: accessToken); // Save accessToken
  }

  Future<String?> getAccessToken() async {
    try {
      Map<String, dynamic>? userDetails =
          await DatabaseHelper().getUserDetails();

      if (!userDetails!.containsKey("accessToken")) {
        if (kDebugMode) {
          log("Did not retreive a valid user from DB");
        }
        return "";
      }

      String authToken = userDetails['accessToken'];

      if (kDebugMode) {
        log("Fetchget access token success");
      }
      return authToken;
    } catch (e) {
      if (kDebugMode) {
        log("Error got");
        debugPrint(e.toString());
        print(e);
      }
      return "";
    }
  }

  Future<void> clearAllStoredData() async {
    await _storage.deleteAll(); // Clear all stored data securely
  }

  Future<void> setSecureKey(String secureKey) async {
    await _storage.write(
        key: 'SecureKey', value: secureKey); // Save accessToken
  }

  Future<void> setLanguage(String t) async {
    await _storage.write(key: 'languageCode', value: t);
  }

  Future<String?> getLanguage() async{
    String? language = await _storage.read(key: 'languageCode');
    return language;
  }

  Future<String?> getTheme({required String key}) async{
    final isDark = await _storage.read(key: key) ?? 'false';
    return isDark;
  }

  Future<void> setTheme({required String key,  required String value}) async {
    await _storage.write(key: key, value: value);
  }

}

  Future<void> setClickedBy(String t) async {
    await _storage.write(key: 'clickedBy', value: t);
  }

  Future<String?> getClickedBy() async {
    String? clickedBy =  await _storage.read(key: 'clickedBy');
    return clickedBy;
  }


}
