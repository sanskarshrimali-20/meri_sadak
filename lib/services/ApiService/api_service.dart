import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constants/base_url_config.dart';

class ApiService {

  final headers = {
    'Content-Type': 'application/json',
    'No-Auth': 'True',
    'Access-Control-Allow-Origin': '*',
  };

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    String url = '${BaseUrlConfig.rootUrl}/$endpoint';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (kDebugMode) {
        debugPrint("Response: ${response.body}");
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error making http request to url $endpoint $e");
        print(stackTrace);
      }

      throw Exception('Error making request: $e');
    }
  }

  Future<http.Response> get(String endpoint, String data) async {
    String url = '${BaseUrlConfig.rootUrl}/$endpoint$data';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (kDebugMode) {
        debugPrint("GetResponse: ${response.body}");
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error in sending post request to $endpoint : $e");
        print(stackTrace);
      }

      throw Exception('Error making request: $e');
    }
  }

  Future<http.Response> postWithAuthToken(String endpoint,  Map<String, dynamic>  body) async {
    String url = '${BaseUrlConfig.rootUrl}$endpoint';
    if (kDebugMode) {
      print("sending post request to $endpoint");
    }

    String valToken = "jekjferkfferffperf";

    final headersAuth = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $valToken',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headersAuth,
        body: body,
      );
      if (kDebugMode) {
        print("Post v1 response ${response.statusCode}");
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error in sending post request to $endpoint: $e");
        print(stackTrace);
      }

      throw Exception('Error making request: $e');
    }
  }

  Future<http.Response> getWithAuthToken(String url) async {

    try {
      String valToken = "jekjferkfferffperf";

      final headersAuth = {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $valToken',
      };

      final response = await http.get(Uri.parse(url), headers: headersAuth);

      if (kDebugMode) {
        debugPrint("GetResponse: ${response.body}");
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error in sending post request to $url : $e");
        print(stackTrace);
      }

      throw Exception('Error making request: $e');
    }
  }

  Future<http.Response> loadXMLMasterData(String url) async {

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'text/xml',
        'Access-Control-Allow-Methods': 'GET',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Access-Control-Allow-Headers, Access-Control-Allow-Origin, Access-Control-Request-Method',
      },
    );

    if (response.statusCode == 200) {
      // If the request was successful, return the XML content as a string
      return response;
    } else {
      // If the request failed, throw an error
      throw Exception('Failed to load XML: ${response.statusCode}');
    }
  }

}
