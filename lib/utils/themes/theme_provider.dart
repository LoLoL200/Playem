import 'package:flutter/material.dart';
import 'package:playem/utils/themes/dark_mode.dart';
import 'package:playem/utils/themes/linght_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themePrefKey = 'isDarkModeKey';

  // Initially, light mode
  ThemeData _themeData = linghtMode;

  // GET theme

  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // Update ui
    notifyListeners();
  }

  // Selecting a topic
  Future<void> initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themePrefKey) ?? false;
    _themeData = isDark ? darkMode : linghtMode;
    notifyListeners();
  }

  // Toggle theme
  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (_themeData == darkMode) {
      _themeData = linghtMode;
      await prefs.setBool(_themePrefKey, false);
    } else {
      _themeData = darkMode;
      await prefs.setBool(_themePrefKey, true);
    }
    notifyListeners();
  }
}
