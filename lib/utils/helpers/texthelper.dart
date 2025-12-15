import 'package:flutter/material.dart';

/// Helper class buat text styling yang sering dipake
class TextHelper {
  TextHelper._();

  /// Text style buat header utama
  static TextStyle headerStyle(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.headlineLarge?.color,
      );

  /// Text style buat sub header
  static TextStyle subHeaderStyle(BuildContext context) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.titleLarge?.color,
      );

  /// Text style buat body text
  static TextStyle bodyStyle(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      );

  /// Text style buat caption
  static TextStyle captionStyle(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).textTheme.bodySmall?.color,
      );

  /// Text style buat button
  static TextStyle buttonStyle(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onPrimary,
      );

  /// Text style buat error message
  static TextStyle errorStyle(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.error,
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
