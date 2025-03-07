import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {

    String path = join(await getDatabasesPath(), 'meri_sadak.db');
    return await openDatabase(
      path,
      version: 6,
      onCreate: (db, version) async {

        await db.execute('PRAGMA foreign_keys = ON;');

        await db.execute('''
          CREATE TABLE user_details (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstname TEXT,
            middlename TEXT,
            lastname TEXT,
            state TEXT,
            district TEXT,
            dob TEXT,
            contact TEXT,
            gender TEXT,
            address TEXT,
            education TEXT,
            pinCode TEXT,
            profilePic TEXT,
            latlong TEXT,
            currentlocation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE user_login (
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
      },
    );
  }

  Future<Map<String, dynamic>?> getUserLoginDetails() async
  {
    try {
      final db = await database;

      final List<Map<String, dynamic>> result = await db.query(
        'user_login',
        limit: 1, // Limits to the first row
      );

      if (result.isNotEmpty) {

        return result.first;
      } else {

        return null; // No entries in the table
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log(e.toString());
        debugPrintStack();
      }

      return null; // If an error occurs, return null
    }
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
