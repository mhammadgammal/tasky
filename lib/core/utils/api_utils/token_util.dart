import 'package:dio/src/response.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/utils/api_utils/api_end_points.dart';
import 'package:tasky/core/utils/api_utils/dio_helper.dart';

import '../../di/di.dart';

abstract class TokenUtil {
  static Future<String> getToken() async {
    var accessToken = sl<CacheHelper>().getString(key: CacheKeys.token) ?? '';
    var refreshToken =
        sl<CacheHelper>().getString(key: CacheKeys.refreshToken) ?? '';

    if (accessToken.isNotEmpty && await _isTokenExpired(accessToken)) {
      var response = await performRefreshToken(refreshToken);
      sl<CacheHelper>().putString(
          key: CacheKeys.token, value: response.data['access_token']);
      return sl<CacheHelper>().getString(key: CacheKeys.token) ?? '';
    } else {
      return accessToken;
    }
  }

  static Future<Response<dynamic>> performRefreshToken(
      String refreshToken) async {
    print('Performing refresh token');
    return await sl<DioHelper>()
        .get(url: '${ApiEndPoints.refreshToken}/$refreshToken');
  }

  static Future<bool> setToken(String token) async =>
      sl<CacheHelper>().putString(key: CacheKeys.token, value: token) ?? false;
  static Future<bool> setRefreshToken(String refreshToken) async =>
      sl<CacheHelper>()
          .putString(key: CacheKeys.refreshToken, value: refreshToken) ??
      false;

  static Future<bool> _isTokenExpired(String token) async =>
      JwtDecoder.isExpired(token);
}
