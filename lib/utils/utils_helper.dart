import 'package:flutter/material.dart';

/// Modern and reusable text styles for AI Bot app
final class AppTextStyles {
  static const String _fontFamily = 'Primary';

  static TextStyle headlineLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: 30,
      color: color,
      fontWeight: fontWeight,
      fontFamily: _fontFamily,
    );
  }

  static TextStyle headlineMedium({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontSize: 25,
      color: color,
      fontWeight: fontWeight,
      fontFamily: _fontFamily,
    );
  }

  static TextStyle bodyLarge({
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
      fontFamily: _fontFamily,
    );
  }

  static TextStyle bodyMedium({
    Color color = Colors.black54,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 15,
      color: color,
      fontWeight: fontWeight,
      fontFamily: _fontFamily,
    );
  }

  static TextStyle caption({
    Color color = Colors.black45,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 11,
      color: color,
      fontWeight: fontWeight,
      fontFamily: _fontFamily,
    );
  }
}