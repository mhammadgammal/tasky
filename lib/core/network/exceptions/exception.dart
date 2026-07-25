class ExceptionBase implements Exception {
  final String? message;

  const ExceptionBase({this.message});
  @override
  String toString() => message ?? super.toString();
}

class ServerException implements Exception {}

class NetworkException implements ExceptionBase {
  const NetworkException({required this.message});

  @override
  final String message;
}

class ValidationException implements ExceptionBase {
  final Map<String, dynamic> errors;
  ValidationException({required this.errors, this.message = ''});

  @override
  final String message;
}

class UnauthorizedException implements ExceptionBase {
  UnauthorizedException({this.message = ''});

  @override
  final String message;
}
class EmptyCashException extends ExceptionBase {}