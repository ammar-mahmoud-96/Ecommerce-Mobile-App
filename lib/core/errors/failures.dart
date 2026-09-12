import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Failure for cache-related errors
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Failure for network-related errors
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

/// Failure for authentication errors
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message = 'Authentication failed'});
}

/// Failure for unknown errors
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unknown error occurred'});
}
