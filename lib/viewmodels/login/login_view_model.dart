import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../services/DatabaseHelper/database_helper.dart';
import '../../services/LocalStorageService/local_storage.dart';

class LoginViewModel extends ChangeNotifier {

  final LocalSecureStorage _localStorage = LocalSecureStorage();

  final dbHelper = DatabaseHelper();

  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get userName => _userName;


  Future<String?> performLogin(String username, String passwordV) async {
    try {
      _setLoading(true);

      /*
       final requestBody = json.encode({
        "username": username,
        "password": passwordV,
      });


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

      final profile = await dbHelper.getSignupDetails(username);
      String phoneNo = profile?['phoneNo'] ?? 'No Name';  // Replace 'phone' with actual field name
      String password = profile?['password'] ?? 'No Name';  // Replace 'name' with actual field name
      String email = profile?['email'] ?? 'No Name';  // Replace 'email' with actual field name


      if((phoneNo == username || email == username) && password == passwordV){
        _localStorage.setLoggingState("true");
        return "Success";
      }
      else{
        return "No user available from this credentials";
      }
      // return "success";
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
