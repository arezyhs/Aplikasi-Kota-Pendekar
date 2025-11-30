import 'package:flutter/material.dart';

/// Helper class buat text styling yang sering dipake
class TextHelper {
  TextHelper._();

  /// Text style buat header utama
  static TextStyle get headerStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  /// Text style buat sub header
  static TextStyle get subHeaderStyle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      );

  /// Text style buat body text
  static TextStyle get bodyStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      );

  /// Text style buat caption
  static TextStyle get captionStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      );

  /// Text style buat button
  static TextStyle get buttonStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  /// Text style buat error message
  static TextStyle get errorStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.red,
      );

  /// Truncate text dengan ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Jadiin huruf pertama tiap kata jadi kapital
  static String capitalizeWords(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
