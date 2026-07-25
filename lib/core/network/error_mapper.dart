import 'dart:developer';

import 'package:dio/dio.dart';

import '../enums/http_status_code.dart';
import '../localization/app_localization.dart';
import 'failures/failure.dart';


class ErrorMapper {
  static Failure fromDioException(DioException exception) {
    if (exception.type == DioExceptionType.connectionTimeout) {
      return ServerFailure('The request connection took too long'.tr());
    }

    final response = exception.response;
    if (response != null) {
      final statusCode = HttpStatusCode.fromCode(response.statusCode);
      return _mapHttpStatusCode(statusCode, response.data);
    }

    return ServerFailure('Something went wrong!'.tr());
  }

  static Failure _mapHttpStatusCode(HttpStatusCode? statusCode, dynamic data) {
    if (statusCode == HttpStatusCode.badGateway) {
      return ServerFailure(data);
    }
    final message = (data is Map<String, dynamic>) ? data['message'] : null;
    final Map<String, dynamic>? errors = (data is Map<String, dynamic>)
        ? data['errors']
        : null;
    log('errors: $errors  \n  ${data['errors']}');
    return switch (statusCode) {
      HttpStatusCode.unauthorized => UnauthorizedFailure(
        message ?? 'Authorization failed.'.tr(),
      ),
      HttpStatusCode.forbidden => ServerFailure(
        message ?? 'You do not have permission to access this resource.'.tr(),
      ),
      HttpStatusCode.notFound => ServerFailure(
        message ?? 'The content you are looking for could not be found.'.tr(),
      ),
      HttpStatusCode.conflict => ServerFailure(
        message ?? 'Conflict with the current data; please try again.'.tr(),
      ),
      // HttpStatusCode.unprocessableEntity => _mapUnprocessableEntityError(data),
      HttpStatusCode.unprocessableEntity => ValidationFailure(
        message,
        errors: errors,
      ),
      HttpStatusCode.tooManyRequests => ServerFailure(
        message ??
            'Rate limit exceeded. Please wait before making more requests.'
                .tr(),
      ),
      HttpStatusCode.badRequest => ServerFailure(
        message ?? 'Bad request. Please check your request parameters.'.tr(),
      ),
      HttpStatusCode.internalServerError => ServerFailure(
        message ?? 'Internal server error. Please try again later.'.tr(),
      ),
      HttpStatusCode.serviceUnavailable => ServerFailure(
        message ?? 'Service unavailable. Please try again later.'.tr(),
      ),
      HttpStatusCode.gatewayTimeout => ServerFailure(
        message ?? 'Gateway timeout. Please try again later.'.tr(),
      ),
      _ => ServerFailure('An unexpected error occurred.'.tr()),
    };
  }
}
