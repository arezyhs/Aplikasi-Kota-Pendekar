import 'package:flutter/material.dart';

const hPrimaryColor = Color.fromARGB(255, 45, 130, 170);
const hSecondaryColor = Color.fromARGB(255, 25, 167, 206);
const hThirdColor = Color.fromARGB(251, 5, 97, 96);
const hForthColor = Color.fromARGB(255, 175, 211, 226);

const hPrimaryLightColor = Color.fromARGB(255, 142, 200, 238);

// Additional theme colors
const hBackgroundLight = Color.fromARGB(255, 239, 245, 248);
const hPrimaryDark = Color.fromARGB(255, 45, 95, 131);

const hPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 25, 167, 206),
    Color.fromARGB(255, 175, 211, 226),
  ],
);

const animationDuration = Duration(milliseconds: 200);

// Typography System - Simplified & Consistent
// Following Material Design guidelines with 4 hierarchical sizes
class AppTextSize {
  static const double caption =
      11.0; // Small text: timestamps, labels, captions
  static const double body = 13.0; // Body text: paragraphs, descriptions
  static const double subtitle = 15.0; // Subtitles: card titles, list items
  static const double heading = 18.0; // Headings: section headers, page titles
  static const double display = 20.0; // Display: large headers, hero text
}

// Font Weight System - Consistent semantic weights
class AppFontWeight {
  static const regular = FontWeight.w400; // Regular body text
  static const medium = FontWeight.w600; // Emphasis, buttons, labels
  static const bold = FontWeight.w700; // Headers, titles, strong emphasis
}

// Spacing System - Comprehensive 8-point grid
class AppSpacing {
  static const double xxs = 2.0; // Minimal spacing
  static const double xs = 4.0; // Very small spacing
  static const double sm = 8.0; // Small spacing
  static const double md = 12.0; // Medium spacing
  static const double lg = 16.0; // Large spacing
  static const double xl = 20.0; // Extra large spacing
  static const double xxl = 24.0; // Maximum spacing
}
