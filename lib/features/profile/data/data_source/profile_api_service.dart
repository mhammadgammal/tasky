import 'package:dio/dio.dart';
import 'package:tasky/core/utils/api_utils/api_end_points.dart';
import 'package:tasky/core/utils/api_utils/dio_helper.dart';

import '../../../../core/di/di.dart';

abstract interface class ProfileApiServiceI {
  Future<Response> getProfile();
}

class ProfileApiService implements ProfileApiServiceI {
  @override
  Future<Response> getProfile() async =>
      await sl<DioHelper>().get(url: ApiEndPoints.profile);
}
