import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../../constants/api_end_point.dart';
import '../../services/ApiService/api_service.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';

class RegisterFeedbackViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final LocalSecureStorage _localStorage = LocalSecureStorage();

  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get userName => _userName;

  final dbHelper = DatabaseHelper();


  Future<String?> registerFeedback(
    Map<String, dynamic> feeBackDetails,
    Map<String, dynamic> imageDetails,
  ) async {
    try {
      _setLoading(true);

      final feedbackWrapper = {
        'images': imageDetails,
        'feedback': feeBackDetails,
        'lang': "en",
        'errorMsg': "",
        'isPmgsy': "",
      };

      if (kDebugMode) {
        log("Request body: $feedbackWrapper");
      }

      // Make API call
      final response = await _apiService.post(
        ApiEndPoints.regFeedback,
        feedbackWrapper,
      );

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
      log("Error during login: $e $stackTrace");

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
