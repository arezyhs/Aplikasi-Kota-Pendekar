import 'package:flutter/foundation.dart';

/// Logging service dengan level support untuk structured logging
///
/// Usage:
/// ```dart
/// Logger.info('User logged in');
/// Logger.warning('API call timeout');
/// Logger.error('Failed to load data', error: e, stackTrace: st);
/// ```
class Logger {
  // Private constructor untuk prevent instantiation
  Logger._();

  /// Log level enum
  static const String _info = 'INFO';
  static const String _warning = 'WARNING';
  static const String _error = 'ERROR';
  static const String _debug = 'DEBUG';

  /// Format log message dengan timestamp dan level
  static String _formatMessage(String level, String message) {
    final timestamp = DateTime.now().toIso8601String();
    return '[$timestamp] [$level] $message';
  }

  /// Log info messages (general information)
  static void info(String message) {
    if (kDebugMode) {
      debugPrint(_formatMessage(_info, message));
    }
  }

  /// Log warning messages (potential issues)
  static void warning(String message) {
    if (kDebugMode) {
      debugPrint(_formatMessage(_warning, message));
    }
  }

  /// Log error messages with optional error object and stack trace
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      debugPrint(_formatMessage(_error, message));
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  /// Log debug messages (detailed technical information)
  static void debug(String message) {
    if (kDebugMode) {
      debugPrint(_formatMessage(_debug, message));
    }
  }

  /// Log API request (simplified version for network calls)
  static void api(String method, String url, {int? statusCode}) {
    if (kDebugMode) {
      final status = statusCode != null ? ' [$statusCode]' : '';
      debugPrint(_formatMessage(_info, 'API $method $url$status'));
    }
  }
}
