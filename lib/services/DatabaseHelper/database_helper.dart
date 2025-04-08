import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/model/feedback_from_model.dart';
import '../../data/model/image_item_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  static const table = 'images';
  static const imageId = 'id';
  static const imagePath = 'image';
  static const imageSource = 'source';
  static const imageLat = 'lat';
  static const imageLong = 'long';
  static const imageTime = 'time';


  static const tableStatus = 'imagesStatus';
  static const columnIdStatus = 'idStatus';
  static const columnImageStatus = 'imageStatus';
  static const columnSourceStatus = 'sourceStatus';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'meri_sadak.db');
    return await openDatabase(
      path,
      version:14,
      onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON;');

        await db.execute('''
          CREATE TABLE sign_up (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            phoneNo TEXT,
            email TEXT,
            password TEXT,
            gender TEXT,
            address TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE login (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE NOT NULL,
            accessToken TEXT UNIQUE NOT NULL,
            refreshToken TEXT UNIQUE NOT NULL,
            encryptionKey TEXT UNIQUE NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE geo_picture(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            picture TEXT,
            currentlocation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE state_district (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            state TEXT,
            district TEXT
          )
        ''');

        await db.execute('''
         CREATE TABLE log_file_sync_status(
          id INTEGER PRIMARY KEY AUTOINCREMENT,  -- Use id instead of if
          log_file_name TEXT UNIQUE,
          log_file_location TEXT,
          createdAt TEXT,
          syncedAt TEXT,
          synced TEXT DEFAULT 'false'
        )
       ''');


        await db.execute('''
        CREATE TABLE localization(
          id INTEGER PRIMARY KEY,
          language_code TEXT,
          localized_data TEXT
        )
        ''');

        await db.execute('''
            CREATE TABLE feedback(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            state TEXT,
            district TEXT,
            block TEXT,
            roadName TEXT,
            staticRoadName TEXT,
            categoryOfComplaint TEXT,
            feedback TEXT
        )
        ''');

        await db.execute('''
         CREATE TABLE $table (
          $imageId INTEGER PRIMARY KEY AUTOINCREMENT,
          $imagePath TEXT,
          $imageSource TEXT,
          $imageLat TEXT,
          $imageLong TEXT,
          $imageTime TEXT
        )
      ''');

        await db.execute('''
            CREATE TABLE allFeedback(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            state TEXT,
            district TEXT,
            block TEXT,
            roadName TEXT,
            staticRoadName TEXT,
            categoryOfComplaint TEXT,
            feedback TEXT,
            lat REAL,
            long REAL,
            dateTime TEXT,
            isFinalSubmit INTEGER DEFAULT 0
        )
        ''');

        await db.execute('''
        CREATE TABLE feedbackImages (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             feedbackId INTEGER NOT NULL, -- Foreign key to reference feedback table
             image TEXT NOT NULL,         -- Path or URL of the image
             source TEXT NOT NULL,        -- Source of the image
             FOREIGN KEY(feedbackId) REFERENCES feedback(id) ON DELETE CASCADE
      )
      ''');

        await db.execute('''
        CREATE TABLE states (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT,
            name TEXT,
            shortCode TEXT,
            hindi TEXT,
            odi TEXT
      )
      ''');

        await db.execute('''
        CREATE TABLE districts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            stateCode TEXT,
            districtCode TEXT,
            name TEXT,
            hindi TEXT,
            odi TEXT
      )
      ''');

        await db.execute('''
        CREATE TABLE blocks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            blockCode TEXT,
            districtCode TEXT,
            name TEXT,
            hindi TEXT,
            odi TEXT
      )
      ''');
      },
    );
  }

  Future<String> setSignupDetails(Map<String, dynamic> signUp) async {
    try {
      final db = await database;
      // Use INSERT OR REPLACE to overwrite any existing record
      await db.insert(
        'sign_up',
        signUp,
        conflictAlgorithm:
            ConflictAlgorithm.replace, // Ensures only one record exists
      );
      return "Success";
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to insert user profile $stackTrace");
        return "Error";
      }
    }
    return "Error";
  }

  Future<String> updateSignupDetails(Map<String, dynamic> signUp, String? user) async {
    try {
      final db = await database;
      debugPrint("User Details $signUp");

      // Assuming 'id' is the unique identifier for each sign-up record.
      // Update the record where the id matches, or insert if no record exists.
      final result = await db.update(
        'sign_up',               // Table name
        signUp,                  // The data to update
        where: 'id = ?',         // Condition to match the record (e.g., 'id' is unique)
        whereArgs: [user], // The value of 'id' to match
      );
      debugPrint("User profile try to update");


      if (result == 0) {
        debugPrint("User profile try to update second");

        // If no rows were updated, it means the record didn't exist, so we insert a new one.
        await db.insert(
          'sign_up',
          signUp,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        debugPrint("User profile try to update third");

      }

      debugPrint("User profile updated successfully");

      return "Success";
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to update user profile $stackTrace");
      }
      return "Error";
    }
  }

  Future<Map<String, dynamic>?> getSignupDetails(String userId) async {
    try {
      final db = await database;

      final List<Map<String, dynamic>> result = await db.query(
        'sign_up',
        where: 'phoneNo = ? OR email = ?',
        whereArgs: [userId], // Use the identifier as the where argument
        limit: 1, // Fetch only one record
      );

      if (result.isNotEmpty) {
        return result.first; // Return the user profile with the matching ID
      } else {
        return null; // Return null if no record exists
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile by id $stackTrace");
      }
      return null; // Return null on error
    }
  }

  Future<String> updatePassword(
    String userIdentifier,
    String newPassword,
  ) async {
    try {
      final db = await database;

      // Update the password for the user with the given userIdentifier (could be userId, email, or phoneNo)
      int updatedRows = await db.update(
        'sign_up',
        {'password': newPassword}, // Set the new password
        where: 'email = ? OR phoneNo = ?',
        // Identify the user by email or phoneNo
        whereArgs: [
          userIdentifier,
          userIdentifier,
        ], // Pass the userIdentifier for email or phoneNo
      );

      if (updatedRows > 0) {
        return "Success";
      } else {
        return "No user found with this identifier";
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to update password $stackTrace");
      }
      return "Error";
    }
  }

  // Insert image into the database
  Future<int> insertImage(ImageItem image) async {
    Database db = await database;
    return await db.insert(table, image.toMap());
  }

  // Get all images from the database
  Future<List<ImageItem>> getAllImages() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return ImageItem.fromMap(maps[i]);
    });
  }

  // Delete image by ID
  Future<int> deleteImage(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$imageId = ?', whereArgs: [id]);
  }

  // Clear all images
  Future<int> clearImages() async {
    Database db = await database;
    return await db.delete(table);
  }

  // Save feedback form data to the database, ensuring it gets updated
  Future<void> saveFeedbackForm(FeedbackFormData feedbackFormData) async {
    final db = await database;

    // Check if there's an existing feedback entry (assuming there will be only one)
    final result = await db.query('feedback', limit: 1);

    if (result.isNotEmpty) {
      // Update the existing row (assuming there's only one entry, update by ID or some identifier)
      await db.update(
        'feedback',
        feedbackFormData.toMap(),
        where: 'id = ?', // Assuming 'id' is the primary key
        whereArgs: [
          result.first['id'],
        ], // Use the existing ID to update the correct row
      );
    } else {
      // If no data exists, insert a new entry
      await db.insert(
        'feedback',
        feedbackFormData.toMap(),
        conflictAlgorithm:
            ConflictAlgorithm.replace, // Replaces any conflicting data
      );
    }
  }

  // Fetch the saved feedback form data from the database
  Future<FeedbackFormData?> getFeedbackForm() async {
    final db = await database;
    final result = await db.query('feedback', limit: 1);
    if (result.isNotEmpty) {
      return FeedbackFormData.fromMap(result.first);
    }
    return null;
  }

  Future<int> clearFeedbackTable() async {
    Database db = await database;
    return await db.delete('feedback');
  }

  Future<void> insertLocalization(
    String languageCode,
    Map<String, String> localizedStrings,
  ) async {
    final db = await database;

    final String localizedData = jsonEncode(localizedStrings);

    await db.insert('localization', {
      'language_code': languageCode,
      'localized_data': localizedData,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch localization data based on language code
  Future<Map<String, String>?> getLocalization(String languageCode) async {
    final db = await database;

    final result = await db.query(
      'localization',
      where: 'language_code = ?',
      whereArgs: [languageCode],
    );

    if (result.isNotEmpty) {
      final localizedData = jsonDecode(
        result.first['localized_data'] as String,
      );
      return Map<String, String>.from(localizedData);
    }
    return null;
  }

  Future<String> insertFeedbackWithImages({
    required String state,
    required String district,
    required String block,
    required String roadName,
    required String staticRoadName,
    required String categoryOfComplaint,
    required String feedback,
    required double lat,
    required double long,
    required String dateTime,
    required List<ImageItem> images,
    required bool isFinalSubmit, // List of image data (image path and source)
  }) async {
    try {
      final db = await database;

      // Insert into feedback table
      int feedbackId = await db.insert('allFeedback', {
        'state': state,
        'district': district,
        'block': block,
        'roadName': roadName,
        'staticRoadName': staticRoadName,
        'categoryOfComplaint': categoryOfComplaint,
        'feedback': feedback,
        'lat': lat,
        'long': long,
        'dateTime': dateTime,
        'isFinalSubmit': isFinalSubmit ? 1 : 0,
        // Store 1 for true, 0 for false
      });

      // Insert images associated with this feedbackId
      for (var imageData in images) {
        await db.insert('feedbackImages', {
          'feedbackId': feedbackId, // Associate image with feedback entry
          'image': imageData.imagePath,
          'source': imageData.source,
        });
      }

      return "Success";
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile $stackTrace");
      }
      return "Error"; // Return null on error
    }
  }

  Future<String> updateFeedbackWithImages({
    required int
    feedbackId, // Pass the feedbackId to identify the feedback to update
    required String state,
    required String district,
    required String block,
    required String roadName,
    required String staticRoadName,
    required String categoryOfComplaint,
    required String feedback,
    required double lat,
    required double long,
    required String dateTime,
    required List<ImageItem> images,
    required bool isFinalSubmit, // List of image data (image path and source)
  }) async {
    try {
      final db = await database;

      // Update the feedback table
      int rowsAffected = await db.update(
        'allFeedback',
        {
          'state': state,
          'district': district,
          'block': block,
          'roadName': roadName,
          'staticRoadName': staticRoadName,
          'categoryOfComplaint': categoryOfComplaint,
          'feedback': feedback,
          'lat': lat,
          'long': long,
          'dateTime': dateTime,
          'isFinalSubmit': isFinalSubmit ? 1 : 0,
        },
        where: 'id = ?', // Use the feedbackId to target the specific row
        whereArgs: [feedbackId],
      );

      if (rowsAffected == 0) {
        return "No feedback found to update"; // If no rows were affected, return a message
      }

      // Delete existing images associated with this feedbackId
      await db.delete(
        'feedbackImages',
        where: 'feedbackId = ?',
        whereArgs: [feedbackId],
      );

      // Insert new images associated with this updated feedbackId
      for (var imageData in images) {
        await db.insert('feedbackImages', {
          'feedbackId': feedbackId,
          // Associate image with updated feedback entry
          'image': imageData.imagePath,
          'source': imageData.source,
        });
      }

      return "Success";
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to update feedback $stackTrace");
      }
      return "Error"; // Return error message if something goes wrong
    }
  }

  Future<List<Map<String, dynamic>>> getFeedbackWithImages(
    int feedbackId,
  ) async {
    final db = await database;

    // Query feedback data
    final feedback = await db.query(
      'allFeedback',
      where: 'id = ?',
      whereArgs: [feedbackId],
    );

    if (feedback.isEmpty) return []; // Return empty if no feedback found

    // Query associated images
    final images = await db.query(
      'feedbackImages',
      where: 'feedbackId = ?',
      whereArgs: [feedbackId],
    );

    return [
      {
        ...feedback.first, // Combine feedback data
        'images': images, // Add associated images as a list
      },
    ];
  }

  Future<List<Map<String, dynamic>>> getFeedbacksByFinalSubmitStatus(bool isFinalSubmit) async {
    try {
      final db = await database;
      final int statusValue = isFinalSubmit ? 1 : 0; // Convert bool to int
      final List<Map<String, dynamic>> feedbacks = await db.query(
        'allFeedback',
        where: 'isFinalSubmit = ?',
        whereArgs: [statusValue],
      );
      return feedbacks;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while fetching feedbacks with isFinalSubmit = $isFinalSubmit $stackTrace");
      }
      return []; // Return an empty list on error
    }
  }



  Future<void> insertStates(Map<String, String> states) async {
    try {
      final db = await database;

      await db.insert('states', states,
        conflictAlgorithm:
        ConflictAlgorithm.replace, );
    }
    catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile $stackTrace");
      }
    }
  }

  Future<List<Map<String, dynamic>>> getStates() async {
    try {
      final db = await database;

      final states = await db.query('states');
      return states;
    }
    catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile $stackTrace");
      }
      return [];
    }
  }

  Future<void> insertDistricts(Map<String, String> districts) async {
    try {
      final db = await database;

      await db.insert('districts', districts,
        conflictAlgorithm:
        ConflictAlgorithm.replace, );
    }
    catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile $stackTrace");
      }
    }
  }

  Future<List<Map<String, dynamic>>> getDistricts(String stateCode) async {
    try {
      final db = await database;

      final districts = await db.query(
        'districts',
        where: 'stateCode = ?',
        whereArgs: [stateCode],
      );
      return districts;
    }
    catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile $stackTrace");
      }
      return [];
    }
  }

  Future<void> insertBlocks(Map<String, String> blocks) async {
    try {
      final db = await database;

      await db.insert('blocks', blocks,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile $stackTrace");
      }
    }
  }


  Future<List<Map<String, dynamic>>> getBlocks(String districtCode) async {
    try {
      final db = await database;

      final districts = await db.query(
        'blocks',
        where: 'districtCode = ?',
        whereArgs: [districtCode],
      );
      return districts;
    }
    catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile $stackTrace");
      }
      return [];
    }
  }


}
