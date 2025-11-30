import 'package:shared_preferences/shared_preferences.dart';

/// Service untuk local storage menggunakan SharedPreferences
class LocalStorageService {
  static SharedPreferences? _prefs;

  /// Inisialisasi SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Ambil nilai string
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Set nilai string
  static Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Ambil nilai int
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Set nilai int
  static Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// Ambil nilai bool
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Set nilai bool
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Hapus nilai
  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Hapus semua data
  static Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  /// Cek apakah key ada
  static bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
}
