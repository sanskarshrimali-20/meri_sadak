import 'package:flutter/material.dart';
import '../services/LocalStorageService/local_storage.dart';  // Import the secure storage package

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default to light mode

  ThemeMode get themeMode => _themeMode;
  final _storage = LocalSecureStorage(); // Secure storage instance


  // Toggle theme between light and dark
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  // Load the saved theme from secure storage
  Future<void> loadTheme() async {
    final isDark = await _storage.getTheme(key: 'isDark') ?? 'false';
    _themeMode = isDark == 'true' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Save the selected theme to secure storage
  Future<void> _saveTheme() async {
    await _storage.setTheme(key: 'isDark', value: _themeMode == ThemeMode.dark ? 'true' : 'false');
  }
}
