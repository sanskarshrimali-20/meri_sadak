import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:meri_sadak/services/DatabaseHelper/database_helper.dart';
import 'package:xml/xml.dart';
import '../../constants/api_end_point.dart';
import '../../constants/base_url_config.dart';
import '../../services/ApiService/api_service.dart';
import '../../services/LocalStorageService/local_storage.dart';

class XmlMasterDataViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  final dbHelper = DatabaseHelper();

  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get userName => _userName;

  Future<void> getStates() async {
    try {
      _setLoading(true);

      String url = 'assets/xml/State_2024.xml';

      // Make API call
      final response = await _apiService.loadXMLMasterData(url);

      final document = XmlDocument.parse(response);

      // Extract each 'row' element
      final rows = document.findAllElements('row');

      // Create a list of states to display
      List<Map<String, String>> states = [];
      for (var row in rows) {
        states.add({
          'code': row.getAttribute('MAST_STATE_CODE') ?? '',
          'name': row.getAttribute('MAST_STATE_NAME') ?? '',
          'shortCode': row.getAttribute('MAST_STATE_SHORT_CODE') ?? '',
          'hindi': row.getAttribute('STATE_HINDI') ?? '',
          'odi': row.getAttribute('STATE_ODI') ?? '',
        });
      }

      for(var state in states){
        await dbHelper.insertStates(state);
      }

    } catch (e, stackTrace) {
      log("Error during login: $e");
      debugPrintStack(stackTrace: stackTrace);

    } finally {
      _setLoading(false);
    }
  }

  Future<void> getDistricts() async {
    try {
      _setLoading(true);

      String url = 'assets/xml/District_2024.xml';
      // Make API call
      final response = await _apiService.loadXMLMasterData(url);

      final document = XmlDocument.parse(response);

      // Extract each 'row' element
      final rows = document.findAllElements('row');

      // Create a list of states to display
      List<Map<String, String>> districts = [];
      for (var row in rows) {
        districts.add({
          'stateCode': row.getAttribute('MAST_STATE_CODE') ?? '',
          'districtCode': row.getAttribute('MAST_DISTRICT_CODE') ?? '',
          'name': row.getAttribute('MAST_DISTRICT_NAME') ?? '',
          'hindi': row.getAttribute('DISTRICT_HINDI') ?? '',
          'odi': row.getAttribute('DISTRICT_ODI') ?? '',
        });
      }

      for(var district in districts){
        await dbHelper.insertDistricts(district);
      }

    } catch (e, stackTrace) {
      log("Error during login: $e");
      debugPrintStack(stackTrace: stackTrace);

    } finally {
      _setLoading(false);
    }
  }

  Future<List<Map<String, dynamic>>> getBlocks(int districtCode) async {

    String blockFileName = "";

    try {
      _setLoading(true);

      if (districtCode > 0 && districtCode <= 100) {
        blockFileName = 'Block_1_To_100.xml';
      }
      if (districtCode > 100 && districtCode <= 200) {
        blockFileName = 'Block_101_To_200.xml';
      }
      if (districtCode > 200 && districtCode <= 300) {
        blockFileName = 'Block_201_To_300.xml';
      }
      if (districtCode > 300 && districtCode <= 400) {
        blockFileName = 'Block_301_To_400.xml';
      }
      if (districtCode > 400 && districtCode <= 500) {
        blockFileName = 'Block_401_To_500.xml';
      }
      if (districtCode > 500 && districtCode <= 600) {
        blockFileName = 'Block_501_To_600.xml';
      }
      if (districtCode > 600 && districtCode <= 700) {
        blockFileName = 'Block_601_To_700.xml';
      }
      if (districtCode > 700 && districtCode <= 800) {
        blockFileName = 'Block_701_To_800.xml';
      }

      if (blockFileName.isNotEmpty) {
        String url = 'assets/xml/DISTRICT_WISE_BLOCK/$blockFileName';
        // Make API call
        final response = await _apiService.loadXMLMasterData(url);

        final document = XmlDocument.parse(response);

        // Extract each 'row' element
        final rows = document.findAllElements('row');

        // Create a list of states to display
        List<Map<String, String>> blocks = [];
        for (var row in rows) {
          blocks.add({
            'blockCode': row.findElements('MAST_BLOCK_CODE').single.text ?? '',
            'districtCode': row.findElements('MAST_DISTRICT_CODE').single.text ?? '',
            'name': row.findElements('MAST_BLOCK_NAME').single.text ?? '',
            'hindi': row.findElements('MAST_BLOCK_HINDI').single.text ?? '',
            'odi': row.findElements('MAST_BLOCK_ODI').single.text ?? '',
          });
        }

        for(var block in blocks){
          await dbHelper.insertBlocks(block);
        }

        debugPrint("blocksParse$blocks");

        return blocks;
      }
      else{
        return [];
      }
    } catch (e, stackTrace) {
      log("Error during login: $e");
      debugPrintStack(stackTrace: stackTrace);

      return [];
    } finally {
      _setLoading(false);
    }
  }

  Future<List<Map<String, dynamic>>> getStatesFromDB() async {

    final states = await dbHelper.getStates();
    return states;
  }

  Future<List<Map<String, dynamic>>> getDistrictsFromDB(String stateCode) async {

    final districts = await dbHelper.getDistricts(stateCode);
    return districts;
  }

  Future<List<Map<String, dynamic>>> getBlocksFromDB(String districtCode) async {
    // Fetch blocks from the database using the districtCode
    final blocks = await dbHelper.getBlocks(districtCode);

    // Check if blocks are available, if not, return an empty list
    if (blocks.isEmpty) {
      return [];
    } else {
      return blocks;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

}
