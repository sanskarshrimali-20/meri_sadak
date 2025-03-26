import 'package:flutter/material.dart';
import '../services/LocalStorageService/local_storage.dart';

class FontSizeProvider with ChangeNotifier {
  final _storage = LocalSecureStorage(); // Secure storage instance
  double _fontSize = 18.0; // Default font size (medium)

  // Constants for small, medium, and large sizes
  static const double smallFontSize = 14.0;
  static const double regularFontSize = 18.0;
  static const double largeFontSize = 22.0;

  // Getter to access the current font size
  double get fontSize => _fontSize;

  // Method to load the font size from secure storage
  Future<void> loadFontSize() async {
    final storedFontSize = await _storage.getFontSize() ?? '18.0';
    _fontSize = double.parse(storedFontSize); // Convert to double
      notifyListeners(); // Notify listeners to update the UI
  }

  // Setter to update the font size and save it to secure storage
  set fontSize(double newFontSize) {
    _fontSize = newFontSize;
    _saveFontSize(newFontSize); // Save new font size to secure storage
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to save the font size to secure storage
  Future<void> _saveFontSize(double newFontSize) async {
    await _storage.setFontSize(newFontSize.toString()); // Save the font size value
  }

  // Method to set font size to small
  void setSmall() {
    _fontSize = smallFontSize;
    _saveFontSize(_fontSize); // Save new font size to secure storage
    notifyListeners();
  }

  // Method to set font size to medium
  void setRegular() {
    _fontSize = regularFontSize;
    _saveFontSize(_fontSize); // Save new font size to secure storage
    notifyListeners();
  }

  // Method to set font size to large
  void setLarge() {
    _fontSize = largeFontSize;
    _saveFontSize(_fontSize); // Save new font size to secure storage
    notifyListeners();
  }
}
