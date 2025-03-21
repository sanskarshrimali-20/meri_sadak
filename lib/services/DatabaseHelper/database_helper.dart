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
  static const columnId = 'id';
  static const columnImage = 'image';
  static const columnSource = 'source';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {

    String path = join(await getDatabasesPath(), 'meri_sadak.db');
    return await openDatabase(
      path,
      version: 8,
      onCreate: (db, version) async {

        await db.execute('PRAGMA foreign_keys = ON;');

        await db.execute('''
          CREATE TABLE sign_up (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            phoneNo TEXT,
            email TEXT,
            password TEXT
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

        await db.execute('PRAGMA foreign_keys = ON;');

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
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnImage TEXT NOT NULL,
          $columnSource TEXT NOT NULL
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
        conflictAlgorithm: ConflictAlgorithm.replace, // Ensures only one record exists
      );
      return "Success";
      debugPrint("User profile inserted successfully");
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to insert user profile");
        print(stackTrace);
        return "Error";
      }
    }
    return "Error";
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
        debugPrint("No user profile found for id: $userId");
        return null; // Return null if no record exists
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile by id");
        print(stackTrace);
      }
      return null; // Return null on error
    }
  }

  Future<String> updatePassword(String userIdentifier, String newPassword) async {
    try {
      final db = await database;

      // Update the password for the user with the given userIdentifier (could be userId, email, or phoneNo)
      int updatedRows = await db.update(
        'sign_up',
        {'password': newPassword}, // Set the new password
        where: 'email = ? OR phoneNo = ?', // Identify the user by email or phoneNo
        whereArgs: [userIdentifier, userIdentifier], // Pass the userIdentifier for email or phoneNo
      );

      if (updatedRows > 0) {
        debugPrint("Password updated successfully");
        return "Success";
      } else {
        debugPrint("No user found with this identifier");
        return "No user found with this identifier";
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to update password");
        print(stackTrace);
      }
      return "Error";
    }
  }

  Future<void> insertUserDetails(Map<String, dynamic> userProfile) async {
    try {
      final db = await database;
      // Use INSERT OR REPLACE to overwrite any existing record
      await db.insert(
        'user_details',
        userProfile,
        conflictAlgorithm: ConflictAlgorithm.replace, // Ensures only one record exists
      );
      debugPrint("User profile inserted successfully");
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to insert user profile");
        print(stackTrace);
      }
    }
  }

  Future<Map<String, dynamic>?> getUserDetailsById(String userId) async {
    try {
      final db = await database;

      // Query the table to fetch the user with the specific ID
      final List<Map<String, dynamic>> result = await db.query(
        'user_details',
        where: 'phoneNo = ?', // Assuming 'id' is the column for user identification
        whereArgs: [userId], // The value to filter by (userId)
        limit: 1, // Fetch only one record
      );

      if (result.isNotEmpty) {
        return result.first; // Return the user profile with the matching ID
      } else {
        debugPrint("No user profile found for id: $userId");
        return null; // Return null if no record exists
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile by id");
        print(stackTrace);
      }
      return null; // Return null on error
    }
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      final db = await database;
      // Query the table and fetch the first record
      final List<Map<String, dynamic>> result = await db.query(
        'user_details',
        limit: 1, // Fetch only one record
      );

      if (result.isNotEmpty) {
        return result.first; // Return the single record
      } else {
        debugPrint("No user profile found");
        return null; // Return null if no record exists
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log("Exception $e while attempting to get user profile");
        print(stackTrace);
      }
      return null; // Return null on error
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
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
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
        whereArgs: [result.first['id']], // Use the existing ID to update the correct row
      );
    } else {
      // If no data exists, insert a new entry
      await db.insert(
        'feedback',
        feedbackFormData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,  // Replaces any conflicting data
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

}
