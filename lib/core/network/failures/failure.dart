import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final Map<String, dynamic>? errors;
  const Failure(this.message, {this.errors});

  @override
  List<Object> get props => [];
}

// No internet connection
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// Server Error (api doesn't return data from server)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Auth Validation
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {required super.errors});
}

// Auth Validation
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class EmptyCashFailure extends Failure {
  const EmptyCashFailure() : super(null);
}

class OfflineFailure extends Failure {
  const OfflineFailure() :super(null);
}