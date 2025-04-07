import 'package:dio/dio.dart';
import 'package:drive_on/src/features/profile/domain/models/profile_user_params.dart';

import 'package:drive_on/src/shared/data/entities/user.dart';
import 'package:retry/retry.dart';

import '../../../../../core/network/error/dio_error_handler.dart';
import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/network/network_url.dart';
import '../../../domain/models/profile_user_model.dart';
import 'profile_datasource_abstract.dart';

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {

  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<User> getProfile(ProfileUserParams params) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    try {
      final response = await r.retry(() => dio.get('$apiUrl/security-contacts/${params.getUserId()}',
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ));

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
            case 400:
              throw ServerException('Error de peticion');
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
    } finally {
      _isFetching = false;
    }
  }

}