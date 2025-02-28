import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../../constants/api_end_point.dart';
import '../../services/ApiService/api_service.dart';
import '../../services/LocalStorageService/local_storage.dart';

class SignUpViewModel extends ChangeNotifier {

  final ApiService _apiService = ApiService();
  final LocalSecureStorage _localStorage = LocalSecureStorage();

  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;
  final bool _isLoggedIn = false;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get userName => _userName;

  bool get isLoggedIn => _isLoggedIn;

  Future<String?> signUpUser(Map<String, dynamic> signUp) async {
    try {
      _setLoading(true);

      if (kDebugMode) {
        log("Request body: $signUp");
      }

      // Make API call
      final response = await _apiService.post(ApiEndPoints.userRegister, signUp);

      if (kDebugMode) {
        log("Response status code: ${response.statusCode}");
        log("Response body: ${response.body}");
      }

      // Handle the database insertion based on platform


      // Set local storage logging state
      // await _localStorage.setLoggingState('true');/
      log("Local storage set to 'true'");

      return "success";
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

}