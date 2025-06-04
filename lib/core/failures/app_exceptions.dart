import 'package:flutter/material.dart';

import 'failure.dart';

// Base App Exception
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.data,
    this.stackTrace,
  });

  Failure toFailure();

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

// Server Exceptions
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });

  factory ServerException.fromStatusCode(int statusCode, {String? message}) {
    switch (statusCode) {
      case 400:
        return ServerException(
          message: message ?? 'Yêu cầu không hợp lệ.',
          code: 'BAD_REQUEST',
        );
      case 401:
        return const ServerException(
          message: 'Phiên đăng nhập đã hết hạn.',
          code: 'UNAUTHORIZED',
        );
      case 403:
        return const ServerException(
          message: 'Bạn không có quyền truy cập.',
          code: 'FORBIDDEN',
        );
      case 404:
        return const ServerException(
          message: 'Không tìm thấy dữ liệu.',
          code: 'NOT_FOUND',
        );
      case 408:
        return const ServerException(
          message: 'Kết nối quá chậm. Vui lòng thử lại.',
          code: 'TIMEOUT',
        );
      case 422:
        return ServerException(
          message: message ?? 'Dữ liệu không hợp lệ.',
          code: 'UNPROCESSABLE_ENTITY',
        );
      case 429:
        return const ServerException(
          message: 'Quá nhiều yêu cầu. Vui lòng thử lại sau.',
          code: 'TOO_MANY_REQUESTS',
        );
      case 500:
        return const ServerException(
          message: 'Lỗi máy chủ. Vui lòng thử lại sau.',
          code: 'INTERNAL_SERVER_ERROR',
        );
      case 502:
        return const ServerException(
          message: 'Máy chủ không phản hồi.',
          code: 'BAD_GATEWAY',
        );
      case 503:
        return const ServerException(
          message: 'Dịch vụ tạm thời không khả dụng.',
          code: 'SERVICE_UNAVAILABLE',
        );
      case 504:
        return const ServerException(
          message: 'Kết nối quá chậm. Vui lòng thử lại.',
          code: 'GATEWAY_TIMEOUT',
        );
      default:
        return ServerException(
          message: message ?? 'Lỗi máy chủ không xác định.',
          code: 'UNKNOWN_SERVER_ERROR',
          data: statusCode,
        );
    }
  }

  @override
  Failure toFailure() {
    return ServerFailure(
      message: message,
      code: code,
      data: data,
    );
  }
}

// Network Exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });

  factory NetworkException.noConnection() {
    return const NetworkException(
      message: 'Không có kết nối internet.',
      code: 'NO_CONNECTION',
    );
  }

  factory NetworkException.timeout() {
    return const NetworkException(
      message: 'Kết nối quá chậm. Vui lòng thử lại.',
      code: 'TIMEOUT',
    );
  }

  factory NetworkException.general(String message) {
    return NetworkException(
      message: message,
      code: 'NETWORK_ERROR',
    );
  }

  @override
  Failure toFailure() {
    return NetworkFailure(
      message: message,
      code: code,
      data: data,
    );
  }
}

// Data Exceptions
class DataException extends AppException {
  const DataException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });

  factory DataException.notFound() {
    return const DataException(
      message: 'Không tìm thấy dữ liệu.',
      code: 'DATA_NOT_FOUND',
    );
  }

  factory DataException.parsing() {
    return const DataException(
      message: 'Lỗi xử lý dữ liệu.',
      code: 'PARSING_ERROR',
    );
  }

  factory DataException.empty() {
    return const DataException(
      message: 'Dữ liệu trống.',
      code: 'EMPTY_DATA',
    );
  }

  factory DataException.invalid(String message) {
    return DataException(
      message: message,
      code: 'INVALID_DATA',
    );
  }

  @override
  Failure toFailure() {
    return DataFailure(
      message: message,
      code: code,
      data: data,
    );
  }
}

// Cache Exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });

  factory CacheException.general() {
    return const CacheException(
      message: 'Lỗi bộ nhớ đệm.',
      code: 'CACHE_ERROR',
    );
  }

  factory CacheException.notFound() {
    return const CacheException(
      message: 'Không tìm thấy dữ liệu trong bộ nhớ đệm.',
      code: 'CACHE_NOT_FOUND',
    );
  }

  factory CacheException.expired() {
    return const CacheException(
      message: 'Dữ liệu đã hết hạn.',
      code: 'CACHE_EXPIRED',
    );
  }

  @override
  Failure toFailure() {
    return CacheFailure(
      message: message,
      code: code,
      data: data,
    );
  }
}

// Authentication Exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });

  factory AuthException.invalidCredentials() {
    return const AuthException(
      message: 'Email hoặc mật khẩu không đúng.',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthException.userNotFound() {
    return const AuthException(
      message: 'Không tìm thấy tài khoản.',
      code: 'USER_NOT_FOUND',
    );
  }

  factory AuthException.emailExists() {
    return const AuthException(
      message: 'Email đã được sử dụng.',
      code: 'EMAIL_EXISTS',
    );
  }

  factory AuthException.weakPassword() {
    return const AuthException(
      message: 'Mật khẩu quá yếu.',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthException.tokenExpired() {
    return const AuthException(
      message: 'Phiên đăng nhập đã hết hạn.',
      code: 'TOKEN_EXPIRED',
    );
  }

  @override
  Failure toFailure() {
    return AuthFailure(
      message: message,
      code: code,
      data: data,
    );
  }
}

// Validation Exceptions
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });

  factory ValidationException.email() {
    return const ValidationException(
      message: 'Email không đúng định dạng.',
      code: 'INVALID_EMAIL',
    );
  }

  factory ValidationException.password() {
    return const ValidationException(
      message: 'Mật khẩu phải có ít nhất 6 ký tự.',
      code: 'INVALID_PASSWORD',
    );
  }

  factory ValidationException.required(String field) {
    return ValidationException(
      message: '$field là bắt buộc.',
      code: 'REQUIRED_FIELD',
      data: field,
    );
  }

  factory ValidationException.custom(String message) {
    return ValidationException(
      message: message,
      code: 'VALIDATION_ERROR',
    );
  }

  @override
  Failure toFailure() {
    return ValidationFailure(
      message: message,
      code: code,
      data: data,
    );
  }
}

// Permission Exceptions
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });

  factory PermissionException.camera() {
    return const PermissionException(
      message: 'Cần quyền truy cập camera.',
      code: 'CAMERA_PERMISSION',
    );
  }

  factory PermissionException.storage() {
    return const PermissionException(
      message: 'Cần quyền truy cập bộ nhớ.',
      code: 'STORAGE_PERMISSION',
    );
  }

  factory PermissionException.location() {
    return const PermissionException(
      message: 'Cần quyền truy cập vị trí.',
      code: 'LOCATION_PERMISSION',
    );
  }

  @override
  Failure toFailure() {
    return PermissionFailure(
      message: message,
      code: code,
      data: data,
    );
  }
}

// Exception Handler Utility
class ExceptionHandler {
  static Failure handleException(Exception exception) {
    if (exception is AppException) {
      return exception.toFailure();
    }

    // Handle generic exceptions
    if (exception.toString().contains('SocketException')) {
      return NetworkFailure.noConnection();
    }

    if (exception.toString().contains('TimeoutException')) {
      return NetworkFailure.timeout();
    }

    if (exception.toString().contains('FormatException')) {
      return DataFailure.parsing();
    }

    // Default failure
    return ServerFailure(
      message: 'Đã có lỗi xảy ra: ${exception.toString()}',
      code: 'UNKNOWN_ERROR',
    );
  }

  static void logException(AppException exception) {
    debugPrint('Exception: ${exception.message}');
    debugPrint('Code: ${exception.code}');
    debugPrint('Data: ${exception.data}');
    if (exception.stackTrace != null) {
      debugPrint('StackTrace: ${exception.stackTrace}');
    }
  }
}