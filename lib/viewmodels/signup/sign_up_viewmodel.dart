import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:meri_sadak/services/EncryptionService/encryption_service.dart';
import '../../constants/api_end_point.dart';
import '../../services/ApiService/api_service.dart';
import '../../services/DatabaseHelper/database_helper.dart';
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
  final dbHelper = DatabaseHelper();


  Future<String?> performSignUp(Map<String, dynamic> signUp) async {
    try {
      _setLoading(true);

     /* final requestBody = json.encode(signUp);

      if (kDebugMode) {
        log("Request body: $requestBody");
      }

      final encryptedRequestBody = EncryptionService().encrypt(requestBody);

      // Make API call
      final response = await _apiService.postV1(ApiEndPoints.userRegister, encryptedRequestBody);

      if (kDebugMode) {
        log("Response status code: ${response.statusCode}");
        log("Response body: ${response.body}");
      }

      bool isSuccessStatus = [200, 201, 203, 204, 205].contains(response.statusCode);

      // Decrypt the response body
      final decryptedResponseBody = EncryptionService().decrypt(response.body);

      var deserializedResponse = jsonDecode(decryptedResponseBody);

*/

        final signUpOperation = await dbHelper.setSignupDetails(signUp);

        if(signUpOperation == "Success"){
          _localStorage.setLoggingState("true");
          return "Success";
        }else{
          return "Error";
        }

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