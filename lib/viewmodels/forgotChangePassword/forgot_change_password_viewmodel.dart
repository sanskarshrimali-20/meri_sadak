import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../../constants/api_end_point.dart';
import '../../services/ApiService/api_service.dart';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';

class ForgotChangePasswordViewModel extends ChangeNotifier {

  final ApiService _apiService = ApiService();
  final LocalSecureStorage _localStorage = LocalSecureStorage();

  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get userName => _userName;
  final dbHelper = DatabaseHelper();


  Future<String?> forgotChangePassword(String userCred, String password) async {
    try {
      _setLoading(true);

      final signUpOperation = await dbHelper.updatePassword(userCred, password);

      if(signUpOperation == "Success"){
        return "Success";
      }else{
        return "Error";
      }

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