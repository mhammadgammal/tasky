import 'package:dio/dio.dart';
import 'package:tasky/core/network/api_end_points.dart';
import 'package:tasky/core/network/dio_helper.dart';

import '../../../../core/di/di.dart';

abstract interface class ProfileApiServiceI {
  Future<Response> getProfile();
}

class ProfileApiService implements ProfileApiServiceI {
  @override
  Future<Response> getProfile() async =>
      await sl<DioHelper>().get(ApiEndPoints.profile);
}
