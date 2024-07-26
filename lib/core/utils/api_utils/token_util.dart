import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/utils/api_utils/api_end_points.dart';
import 'package:tasky/core/utils/api_utils/api_error_handler.dart';
import 'package:tasky/core/utils/api_utils/dio_helper.dart';
import 'package:tasky/core/widgets/session_ended_dialogue.dart';

import '../../di/di.dart';

abstract class TokenUtil {
  static Future<String> getToken() async {
    var accessToken = sl<CacheHelper>().getString(key: CacheKeys.token) ?? '';
    var refreshToken =
        sl<CacheHelper>().getString(key: CacheKeys.refreshToken) ?? '';

    if (refreshToken.isNotEmpty && await _isTokenExpired(accessToken)) {
      try {
        var response = await performRefreshToken(refreshToken);
        if (response.statusCode == 200) {
          var newAccessToken = response.data['access_token'];
          await setToken(newAccessToken);
          return newAccessToken;
        } else {
          // Handle failed token refresh
          print('Failed to refresh token: ${response.statusCode}');
          return '';
        }
      } on DioException catch (e) {
        // Handle exception during token refresh
        print('Exception during token refresh: $e');
        String errorMessage =
            ApiErrorHandler.handelErrorMessage(e.response?.statusCode ?? -1);
        showToast(errorMessage);
        if (e.response?.statusCode == 401) {
          // Handle unauthorized
          await logout();
          showDialog(
              context: sl<BuildContext>(),
              builder: (context) => const SessionEndedDialogue(
                  errorMessage: 'Session Ended, Please Resign in'));
          return '';
        } else if (e.response?.statusCode == 403) {
          // Handle forbidden
          showToast('Forbidden: Access denied.');
          return '';
        } else {
          // Handle other status codes
          showToast(errorMessage);
          return '';
        }
      }
    } else {
      return accessToken;
    }
  }

  static Future<Response<dynamic>> performRefreshToken(
      String refreshToken) async {
    print('Performing refresh token');
    return await sl<DioHelper>()
        .get(url: '${ApiEndPoints.refreshToken}?token=$refreshToken');
  }

  static Future<bool> setToken(String token) async =>
      sl<CacheHelper>().putString(key: CacheKeys.token, value: token) ?? false;

  static Future<bool> setRefreshToken(String refreshToken) async =>
      sl<CacheHelper>()
          .putString(key: CacheKeys.refreshToken, value: refreshToken) ??
      false;

  static Future<bool> _isTokenExpired(String token) async =>
      JwtDecoder.isExpired(token);

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static logout() {}
}
