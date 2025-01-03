import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DesignTokens {
  static late Map<String, dynamic> _tokens;
  static bool _isDark = false;

  static Future<void> initialize() async {
    // Load tokens from assets
    final String jsonContent = await rootBundle.loadString('assets/design_token.json');
    _tokens = json.decode(jsonContent);
  }

  static Color getColor(String colorPath) {
    final theme = _isDark ? 'dark' : 'light';
    final colorValue = _getNestedValue('$theme.colors.$colorPath');
    return Color(int.parse(colorValue.replaceAll('#', '0xFF')));
  }

  static double getSpacing(String key) {
    final theme = _isDark ? 'dark' : 'light';
    return _getNestedValue('$theme.spacing.$key').toDouble();
  }

  static TextStyle getTextStyle(String key) {
    final theme = _isDark ? 'dark' : 'light';
    final typography = _getNestedValue('$theme.typography.$key');

    return TextStyle(
      fontSize: typography['fontSize'].toDouble(),
      fontWeight: _getFontWeight(typography['fontWeight']),
      letterSpacing: typography['letterSpacing'].toDouble(),
      color: getColor('text.primary'),
    );
  }

  static dynamic _getNestedValue(String path) {
    final keys = path.split('.');
    dynamic value = _tokens;

    for (final key in keys) {
      value = value[key];
    }

    return value;
  }

  static FontWeight _getFontWeight(String weight) {
    switch (weight) {
      case 'light':
        return FontWeight.w300;
      case 'regular':
        return FontWeight.w400;
      case 'medium':
        return FontWeight.w500;
      case 'bold':
        return FontWeight.w700;
      default:
        return FontWeight.w400;
    }
  }

  static void setThemeMode(bool isDark) {
    _isDark = isDark;
  }
}

class AppTheme {

  static ThemeData getTheme(bool isDark) {
    DesignTokens.setThemeMode(isDark);

    return ThemeData(
      // brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: DesignTokens.getColor('primary'),
      scaffoldBackgroundColor: DesignTokens.getColor('background'),
      // scaffoldBackgroundColor: Colors.deepPurple,
      // errorColor: DesignTokens.getColor('error'),
      textTheme: TextTheme(
        displayLarge: DesignTokens.getTextStyle('h1'),
        bodyLarge: DesignTokens.getTextStyle('body1'),
      ),

    );
  }
}