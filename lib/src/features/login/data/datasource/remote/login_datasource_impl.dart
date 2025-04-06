import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drive_on/src/core/network/error/exceptions.dart';
import 'package:drive_on/src/core/network/network_url.dart';
import 'package:drive_on/src/features/login/data/entities/user.dart';
import 'package:drive_on/src/features/login/domain/models/login_user_model.dart';

import 'package:drive_on/src/features/login/domain/models/login_user_params.dart';
import 'package:retry/retry.dart';

import '../../../../../core/network/error/dio_error_handler.dart';
import 'login_datasource_abst.dart';

class LoginDatasourceImpl extends LoginDatasource {
  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<User> loginUser(UserParams params) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3); // implement

    try {
      final response = await dio.post('$apiUrl/auth/login',
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: jsonEncode(params)
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) { // Simplify
      if (e.response != null) {
        if (e.response!.data != null) {
          if (e.response!.data['message'] != null) {
            throw ServerException(e.response!.data['message']);
          } else {
            throw ServerException(handleDioError(e));
          }
        } else {
          switch (e.response!.statusCode) {
            case 401:
              throw ServerException('Usuario invalido');
            case 403:
              throw ServerException('Cuenta no autorizada');
            default:
              throw ServerException(handleDioError(e));
          }
        }
      } else {
        if (e.type == DioExceptionType.cancel) {
          throw CacheException(handleDioError(e));
        } else {
          throw ServerException(handleDioError(e));
        }
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
