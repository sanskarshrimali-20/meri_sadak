import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../../constants/api_end_point.dart';
import '../../constants/base_url_config.dart';
import '../../services/ApiService/api_service.dart';
import '../../services/LocalStorageService/local_storage.dart';

class GetReplyFileFeedbackViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final LocalSecureStorage _localStorage = LocalSecureStorage();

  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get userName => _userName;

  Future<String?> getReplyFileFeedback(String feedbackID, String feedbackStatus) async {
    try {
      _setLoading(true);

      String endPoint = ApiEndPoints.getReplyForFeedback;
      String url = '${BaseUrlConfig.rootUrl}/$endPoint$feedbackID"&feedbackStatus="$feedbackStatus"&lang=""CurrentLang"';

      // Make API call
      final response = await _apiService.getWithAuthToken(url);

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
