import 'package:flutter/foundation.dart';

enum Environment { development, staging, production }

class AppConfig {
  static Environment _environment = Environment.development;
  static late AppConfig _instance;

  final String appName;
  final String appVersion;
  final String baseUrl;
  final String apiKey;
  final bool enableLogging;
  final int requestTimeout;
  final bool enableCrashlytics;
  final bool enableAnalytics;

  AppConfig._({
    required this.appName,
    required this.appVersion,
    required this.baseUrl,
    required this.apiKey,
    required this.enableLogging,
    required this.requestTimeout,
    required this.enableCrashlytics,
    required this.enableAnalytics,
  });

  static AppConfig get instance => _instance;
  static Environment get environment => _environment;
  static bool get isDevelopment => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;
  static bool get isDebug => kDebugMode;
  static bool get isRelease => kReleaseMode;

  static void initialize(Environment environment) {
    _environment = environment;
    
    switch (environment) {
      case Environment.development:
        _instance = AppConfig._(
          appName: 'GrabFood Clone (Dev)',
          appVersion: '1.0.0-dev',
          baseUrl: 'https://dev-api.grabfood-clone.com',
          apiKey: 'dev_api_key_12345',
          enableLogging: true,
          requestTimeout: 30000,
          enableCrashlytics: false,
          enableAnalytics: false,
        );
        break;
        
      case Environment.staging:
        _instance = AppConfig._(
          appName: 'GrabFood Clone (Staging)',
          appVersion: '1.0.0-staging',
          baseUrl: 'https://staging-api.grabfood-clone.com',
          apiKey: 'staging_api_key_12345',
          enableLogging: true,
          requestTimeout: 20000,
          enableCrashlytics: true,
          enableAnalytics: false,
        );
        break;
        
      case Environment.production:
        _instance = AppConfig._(
          appName: 'GrabFood Clone',
          appVersion: '1.0.0',
          baseUrl: 'https://api.grabfood-clone.com',
          apiKey: 'prod_api_key_12345',
          enableLogging: false,
          requestTimeout: 15000,
          enableCrashlytics: true,
          enableAnalytics: true,
        );
        break;
    }
  }

  // Feature Flags
  static const bool enableBranchSelection = true;
  static const bool enablePushNotifications = true;
  static const bool enableBiometricAuth = true;
  static const bool enableDarkMode = true;
  static const bool enableOfflineMode = false;
  static const bool enableA11yFeatures = true;

  // App Settings
  static const int maxRetryAttempts = 3;
  static const Duration cacheExpiration = Duration(hours: 1);
  static const int maxImageCacheSize = 100; // MB
  static const int paginationLimit = 20;

  // UI Settings
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 2.0;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const double minTapTargetSize = 44.0;

  // Business Rules
  static const double minOrderAmount = 50000; // VND
  static const double deliveryFee = 15000; // VND
  static const Duration orderTimeout = Duration(minutes: 30);
  static const int maxCartItems = 50;

  // Logging
  static void log(String message, {String? tag}) {
    if (instance.enableLogging) {
      final timestamp = DateTime.now().toIso8601String();
      final logTag = tag ?? 'APP';
      debugPrint('[$timestamp] [$logTag] $message');
    }
  }

  static void logError(String message, {Object? error, StackTrace? stackTrace}) {
    if (instance.enableLogging) {
      final timestamp = DateTime.now().toIso8601String();
      debugPrint('[$timestamp] [ERROR] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  // Debug Info
  static Map<String, dynamic> getDebugInfo() {
    return {
      'environment': _environment.toString(),
      'appName': instance.appName,
      'appVersion': instance.appVersion,
      'baseUrl': instance.baseUrl,
      'enableLogging': instance.enableLogging,
      'isDebug': isDebug,
      'isRelease': isRelease,
      'platform': defaultTargetPlatform.toString(),
    };
  }

  @override
  String toString() {
    return 'AppConfig(environment: $_environment, appName: $appName, version: $appVersion)';
  }
}