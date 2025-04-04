import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../constants/base_url_config.dart';

class ApiService {

  late HttpClient httpClient;
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
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error making http request to url $endpoint $e : $stackTrace");

      }

      throw Exception('Error making request: $e');
    }
  }

  Future<http.Response> get(String endpoint, String data) async {
    String url = '${BaseUrlConfig.rootUrl}/$endpoint$data';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (kDebugMode) {
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error in sending post request to $endpoint: $e : $stackTrace");
      }

      throw Exception('Error making request: $e');
    }
  }

  Future<http.Response> postWithAuthToken(String endpoint,  Map<String, dynamic>  body) async {
    String url = '${BaseUrlConfig.rootUrl}$endpoint';
    if (kDebugMode) {
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
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error in sending post request to $endpoint: $e : $stackTrace");
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
      }

      return response;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Error in sending post request to $url : $e : $stackTrace");
      }

      throw Exception('Error making request: $e');
    }
  }

  Future<String> loadXMLMasterData(String url) async {

    try {
      return await rootBundle.loadString(url);
    } catch (e) {
      throw Exception('Failed to load XML: $e');
    }
  }

}
