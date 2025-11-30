import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';

/// Helper buat warna-warna yang sering dipake
class ColorHelper {
  ColorHelper._();

  /// Warna utama dengan transparansi
  static Color primaryWithOpacity(double opacity) {
    return hPrimaryColor.withOpacity(opacity);
  }

  /// Warna kedua dengan transparansi
  static Color secondaryWithOpacity(double opacity) {
    return hSecondaryColor.withOpacity(opacity);
  }

  /// Gradient buat app bar
  static LinearGradient get appBarGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [hPrimaryColor, hSecondaryColor],
      );

  /// Gradient buat tombol
  static LinearGradient get buttonGradient => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [hSecondaryColor, hPrimaryColor],
      );

  /// Warna buat loading indicator
  static Color get loadingColor => hThirdColor;

  /// Warna untuk error state
  static Color get errorColor => Colors.red.shade600;

  /// Warna untuk success state
  static Color get successColor => Colors.green.shade600;

  /// Warna untuk warning state
  static Color get warningColor => Colors.orange.shade600;

  /// Background gradient buat card
  static LinearGradient get cardGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          hForthColor.withOpacity(0.1),
        ],
      );
}
