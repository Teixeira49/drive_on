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
      final data = await dio.post('$apiUrl/auth/login',
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: params.toJson()
      );
      return UserModel.fromJson(data);
    } on DioException catch (e) {
      if (e.type == DioErrorType.cancel) {
        throw CacheException(handleDioError(e));
      } else {
        throw ServerException(handleDioError(e));
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
