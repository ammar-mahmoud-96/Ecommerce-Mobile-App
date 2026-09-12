/// Base class for all exceptions in the application
class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

/// Exception for server-related errors
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

/// Exception for cache-related errors
class CacheException extends AppException {
  const CacheException({super.message = 'Cache error occurred'});
}

/// Exception for network-related errors
class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection'});
}

/// Exception for validation errors
class ValidationException extends AppException {
  const ValidationException({required super.message});
}

/// Exception for authentication errors
class AuthenticationException extends AppException {
  const AuthenticationException({super.message = 'Authentication failed'});
}

/// Exception for not found errors
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
  });
}
