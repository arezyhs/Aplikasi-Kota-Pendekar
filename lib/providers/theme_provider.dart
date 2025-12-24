import 'package:flutter/material.dart';
import 'package:pendekar/utils/services/local_storage_service.dart';
import 'package:pendekar/utils/services/logger_service.dart';
import 'package:pendekar/constants/constant.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeNotifier() {
    _loadTheme();
  }

  void _loadTheme() {
    _isDarkMode = LocalStorageService.getBool('dark_mode') ?? false;
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    await LocalStorageService.setBool('dark_mode', isDark);
    Logger.info('🌙 Dark mode toggled to: $isDark');
    notifyListeners();
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1976D2),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      cardColor: Colors.white,
      dividerColor: Colors.grey[300],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: AppTextSize.display,
          fontWeight: AppFontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1976D2),
        unselectedItemColor: Colors.grey[600],
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1976D2),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      dividerColor: Colors.grey[800],
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: AppTextSize.display,
          fontWeight: AppFontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: Color(0xFF64B5F6),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Global instance
final themeNotifier = ThemeNotifier();
