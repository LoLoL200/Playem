import 'package:flutter/material.dart';
import 'package:playem/utils/themes/dark_mode.dart';
import 'package:playem/utils/themes/light_mode.dart';
import 'package:playem/utils/themes/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themePrefKey = 'isDarkModeKey';

  // Initially, light mode
  ThemeData _themeData = lightMode;

  late TextStyle _currentAppBarStyle;
  late TextStyle _currentStyle;

  // GET theme
  TextStyle get appBarStyle => _currentAppBarStyle;
  TextStyle get style => _currentStyle;

  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // Update ui
    notifyListeners();
  }

ThemeProvider([ThemeData? initialTheme])
  : _themeData = initialTheme ?? lightMode,
    _currentAppBarStyle = (initialTheme ?? lightMode) == darkMode ? homeAppBardark : homeAppBarlight,
    _currentStyle = (initialTheme ?? lightMode) == darkMode ? homedark : homelight;

  // Selecting a topic
  Future<void> initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themePrefKey) ?? false;
    _themeData = isDark ? darkMode : lightMode;
    _currentStyle = _themeData == darkMode ? homedark : homelight;
    _currentAppBarStyle = _themeData == darkMode ? homeAppBardark : homeAppBarlight;

    notifyListeners();
  }

    // Toggle theme


 void _setStylesFromTheme() {
  _currentAppBarStyle = isDarkMode ? homeAppBardark : homeAppBarlight;
  _currentStyle = isDarkMode ? homedark : homelight;
}
   
 void toggleTheme() async {
  final prefs = await SharedPreferences.getInstance();

  if (isDarkMode) {
    _themeData = lightMode;
  } else {
    _themeData = darkMode;
  }

  _setStylesFromTheme();
  await prefs.setBool(_themePrefKey, isDarkMode);

  notifyListeners();
}

  
}
