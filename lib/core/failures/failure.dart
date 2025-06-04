import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic data;

  const Failure({
    required this.message,
    this.code,
    this.data,
  });

  @override
  List<Object?> get props => [message, code, data];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

// Server Related Failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory ServerFailure.general() {
    return const ServerFailure(
      message: 'Lỗi máy chủ. Vui lòng thử lại sau.',
      code: 'SERVER_ERROR',
    );
  }

  factory ServerFailure.timeout() {
    return const ServerFailure(
      message: 'Kết nối quá chậm. Vui lòng thử lại.',
      code: 'TIMEOUT',
    );
  }

  factory ServerFailure.unauthorized() {
    return const ServerFailure(
      message: 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
      code: 'UNAUTHORIZED',
    );
  }

  factory ServerFailure.forbidden() {
    return const ServerFailure(
      message: 'Bạn không có quyền truy cập.',
      code: 'FORBIDDEN',
    );
  }

  factory ServerFailure.notFound() {
    return const ServerFailure(
      message: 'Không tìm thấy dữ liệu.',
      code: 'NOT_FOUND',
    );
  }

  factory ServerFailure.badRequest(String message) {
    return ServerFailure(
      message: message,
      code: 'BAD_REQUEST',
    );
  }
}

// Network Related Failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory NetworkFailure.noConnection() {
    return const NetworkFailure(
      message: 'Không có kết nối internet. Vui lòng kiểm tra và thử lại.',
      code: 'NO_CONNECTION',
    );
  }

  factory NetworkFailure.timeout() {
    return const NetworkFailure(
      message: 'Kết nối quá chậm. Vui lòng thử lại.',
      code: 'TIMEOUT',
    );
  }

  factory NetworkFailure.general() {
    return const NetworkFailure(
      message: 'Lỗi kết nối. Vui lòng thử lại.',
      code: 'NETWORK_ERROR',
    );
  }
}

// Data Related Failures
class DataFailure extends Failure {
  const DataFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory DataFailure.notFound() {
    return const DataFailure(
      message: 'Không tìm thấy dữ liệu.',
      code: 'DATA_NOT_FOUND',
    );
  }

  factory DataFailure.parsing() {
    return const DataFailure(
      message: 'Lỗi xử lý dữ liệu.',
      code: 'PARSING_ERROR',
    );
  }

  factory DataFailure.empty() {
    return const DataFailure(
      message: 'Dữ liệu trống.',
      code: 'EMPTY_DATA',
    );
  }

  factory DataFailure.invalid(String message) {
    return DataFailure(
      message: message,
      code: 'INVALID_DATA',
    );
  }
}

// Cache Related Failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory CacheFailure.general() {
    return const CacheFailure(
      message: 'Lỗi bộ nhớ đệm.',
      code: 'CACHE_ERROR',
    );
  }

  factory CacheFailure.notFound() {
    return const CacheFailure(
      message: 'Không tìm thấy dữ liệu trong bộ nhớ đệm.',
      code: 'CACHE_NOT_FOUND',
    );
  }

  factory CacheFailure.expired() {
    return const CacheFailure(
      message: 'Dữ liệu đã hết hạn.',
      code: 'CACHE_EXPIRED',
    );
  }
}

// Authentication Related Failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory AuthFailure.invalidCredentials() {
    return const AuthFailure(
      message: 'Email hoặc mật khẩu không đúng.',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthFailure.userNotFound() {
    return const AuthFailure(
      message: 'Không tìm thấy tài khoản.',
      code: 'USER_NOT_FOUND',
    );
  }

  factory AuthFailure.emailAlreadyExists() {
    return const AuthFailure(
      message: 'Email đã được sử dụng.',
      code: 'EMAIL_EXISTS',
    );
  }

  factory AuthFailure.weakPassword() {
    return const AuthFailure(
      message: 'Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthFailure.tokenExpired() {
    return const AuthFailure(
      message: 'Phiên đăng nhập đã hết hạn.',
      code: 'TOKEN_EXPIRED',
    );
  }

  factory AuthFailure.accountDisabled() {
    return const AuthFailure(
      message: 'Tài khoản đã bị vô hiệu hóa.',
      code: 'ACCOUNT_DISABLED',
    );
  }
}

// Validation Related Failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory ValidationFailure.email() {
    return const ValidationFailure(
      message: 'Email không đúng định dạng.',
      code: 'INVALID_EMAIL',
    );
  }

  factory ValidationFailure.password() {
    return const ValidationFailure(
      message: 'Mật khẩu phải có ít nhất 6 ký tự.',
      code: 'INVALID_PASSWORD',
    );
  }

  factory ValidationFailure.required(String field) {
    return ValidationFailure(
      message: '$field là bắt buộc.',
      code: 'REQUIRED_FIELD',
      data: field,
    );
  }

  factory ValidationFailure.custom(String message) {
    return ValidationFailure(
      message: message,
      code: 'VALIDATION_ERROR',
    );
  }
}

// Permission Related Failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory PermissionFailure.camera() {
    return const PermissionFailure(
      message: 'Cần quyền truy cập camera.',
      code: 'CAMERA_PERMISSION',
    );
  }

  factory PermissionFailure.storage() {
    return const PermissionFailure(
      message: 'Cần quyền truy cập bộ nhớ.',
      code: 'STORAGE_PERMISSION',
    );
  }

  factory PermissionFailure.location() {
    return const PermissionFailure(
      message: 'Cần quyền truy cập vị trí.',
      code: 'LOCATION_PERMISSION',
    );
  }

  factory PermissionFailure.notifications() {
    return const PermissionFailure(
      message: 'Cần quyền gửi thông báo.',
      code: 'NOTIFICATION_PERMISSION',
    );
  }
}