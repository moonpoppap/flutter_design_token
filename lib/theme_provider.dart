import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'design_tokens.dart';

// Theme Provider using ChangeNotifier
class ThemeProvider with ChangeNotifier {
  static const String THEME_KEY = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    // if (_themeMode == ThemeMode.system) {
    //   // Get device theme mode
    //   final window = WidgetsBinding.instance.window;
    //   return window.platformBrightness == Brightness.dark;
    // }
    return _themeMode == ThemeMode.dark;
  }

  ThemeProvider() {
    _loadThemeMode();
  }

  // Load theme from SharedPreferences
  Future<void> _loadThemeMode() async {
    await DesignTokens.initialize();
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(THEME_KEY);

    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
            (e) => e.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }else {
      _themeMode = ThemeMode.system;
    }
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(THEME_KEY, mode.toString());
  }

  // Toggle between light and dark mode
  Future<void> toggleTheme() async {
    // if (_themeMode == ThemeMode.light) {
    //   _themeMode = ThemeMode.dark;
    // } else if (_themeMode == ThemeMode.dark) {
    //   _themeMode = ThemeMode.light;
    // } else {
      // If system mode, switch to light/dark based on current system theme
      _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    // }

    await _saveThemeMode(_themeMode);
    notifyListeners();
  }

  // Set specific theme mode
  // Future<void> setThemeMode(ThemeMode mode) async {
  //   _themeMode = mode;
  //   await _saveThemeMode(mode);
  //   notifyListeners();
  // }
}


// class ThemeProvider with ChangeNotifier {
//   static const String THEME_KEY = 'theme_mode';
//
//   ThemeMode _themeMode = ThemeMode.system;
//
//   ThemeMode get themeMode => _themeMode;
//
//   bool get isDarkMode {
//     if (_themeMode == ThemeMode.system) {
//       // Get device theme mode
//       final window = WidgetsBinding.instance.window;
//       return window.platformBrightness == Brightness.dark;
//     }
//     return _themeMode == ThemeMode.dark;
//   }
//
//   // Constructor - Load saved theme
//   ThemeProvider() {
//     _loadThemeMode();
//   }
//
//   // Load theme from SharedPreferences
//   Future<void> _loadThemeMode() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedTheme = prefs.getString(THEME_KEY);
//
//     if (savedTheme != null) {
//       _themeMode = ThemeMode.values.firstWhere(
//             (e) => e.toString() == savedTheme,
//         orElse: () => ThemeMode.system,
//       );
//       notifyListeners();
//     }
//   }
//
//   // Save theme to SharedPreferences
//   Future<void> _saveThemeMode(ThemeMode mode) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(THEME_KEY, mode.toString());
//   }
//
//   // Toggle between light and dark mode
//   Future<void> toggleTheme() async {
//     if (_themeMode == ThemeMode.light) {
//       _themeMode = ThemeMode.dark;
//     } else if (_themeMode == ThemeMode.dark) {
//       _themeMode = ThemeMode.light;
//     } else {
//       // If system mode, switch to light/dark based on current system theme
//       _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
//     }
//
//     await _saveThemeMode(_themeMode);
//     notifyListeners();
//   }
//
//   // Set specific theme mode
//   Future<void> setThemeMode(ThemeMode mode) async {
//     _themeMode = mode;
//     await _saveThemeMode(mode);
//     notifyListeners();
//   }
// }
