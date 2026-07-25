import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../localization/app_localization.dart';
import 'error_mapper.dart';
import 'exceptions/exception.dart';
import 'failures/failure.dart';

/*
  Generic response handler for mapping API responses to domain models.
  Note: Please make sure to add the necessary Unit tests for this function 
        if you add a new feature or modify the existing one.
*/
Future<Either<Failure, T>> handleResponse<T>(
  Future<Response<dynamic>> remoteCall,
  T Function(Response response) mapFunction,
) async {
  try {
    final Response response = await remoteCall;
    return Right(mapFunction(response));
  } on TypeError catch (e) {
    log('TypeError: ${e.toString()}\nStackTrace: ${e.stackTrace}');
    return Left(ServerFailure('Data parsing error: ${e.toString()}'.tr()));
  } on DioException catch (e) {
    return Left(ErrorMapper.fromDioException(e));
  } on NetworkException catch (e) {
    return Left(NetworkFailure(e.message));
  } catch (e) {
    return Left(ServerFailure('An Unexpected error occurred'.tr()));
  }
}
