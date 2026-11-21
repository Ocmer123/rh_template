import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Tiny logger. Use this instead of `print` (the `avoid_print` lint is on).
/// Debug and info messages are dropped in release builds; never log personal data.
abstract final class Log {
  static void debug(String message) {
    if (kDebugMode) developer.log(message, name: 'debug');
  }

  static void info(String message) {
    if (kDebugMode) developer.log(message, name: 'info');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'error',
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}
