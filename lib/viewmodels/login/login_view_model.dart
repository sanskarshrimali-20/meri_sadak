import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../services/ApiService/api_service.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final LocalSecureStorage _localStorage = LocalSecureStorage();

  final dbHelper = DatabaseHelper();

  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get userName => _userName;


  Future<String?> performLogin(String username, String passwordValue) async {
    try {
      _setLoading(true);

     /* final requestBody = {
        "username": username,
        "password": password,
      };

      if (kDebugMode) {
        log("Request body: $requestBody");
      }

      // Make API call
      final response = await _apiService.post(ApiEndPoints.login, requestBody);

      if (kDebugMode) {
        log("Response status code: ${response.statusCode}");
        log("Response body: ${response.body}");
      }

      // Handle the database insertion based on platform


      // Set local storage logging state
      // await _localStorage.setLoggingState('true');/
      log("Local storage set to 'true'");
*/

      final profile = await dbHelper.getSignupDetails(username);
      String phoneNo = profile?['phoneNo'] ?? 'No Name';  // Replace 'phone' with actual field name
      String password = profile?['password'] ?? 'No Name';  // Replace 'name' with actual field name
      String email = profile?['email'] ?? 'No Name';  // Replace 'email' with actual field name

      debugPrint("profileValue$profile");
      debugPrint("password$password");
      debugPrint("passwordValue$passwordValue");

      if((phoneNo == username || email == username) && password == passwordValue){
        _localStorage.setLoggingState("true");
        return "Success";
      }
      else{
        return "No user available from this credentials";
      }
      // return "success";
    } catch (e, stackTrace) {
      log("Error during login: $e");
      debugPrintStack(stackTrace: stackTrace);

      return "Failed to login. Please check your credentials and try again.";
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  String responseMessage(String decryptedResponseBody){
    final jsonResponse = json.decode(decryptedResponseBody);

    if (kDebugMode) {
      log('response not 200 ');
      log(jsonResponse.statusCode.toString());
      log(jsonResponse.body);
    }

    return jsonResponse["message"].toString();
  }
}
