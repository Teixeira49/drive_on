import 'package:dio/dio.dart';
import 'package:drive_on/src/features/crud_contact/domain/models/crud_contacts_params.dart';
import 'package:retry/retry.dart';

import '../../../../../core/network/error/dio_error_handler.dart';
import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/network/network_url.dart';
import '../../../../../shared/domain/models/security_contacts_model.dart';
import 'crud_contacts_datasource_abstract.dart';

class ContactsRemoteDatasourceImpl extends ContactsRemoteDatasource {
  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<String> addSecurityContact(CRUDSecurityContactsParams params) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final getList = params.getContactList();
    final sendList = [];

    for (var i in getList) {
      sendList.add(SecurityContactsModel.fromEntity(i).toJson());
    }

    sendList.add(params.getUpdatedContact());

    try {
      final response = await r.retry(
          () => dio.post('$apiUrl/security-contacts/${params.getUserId()}',
              options: Options(
                sendTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
              data: {'contacts': sendList}));

      return response.data['message'];
    } on DioException catch (e) {
      // Simplify
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

  @override
  Future<String> updateSecurityContact(CRUDSecurityContactsParams params) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final getList = params.getContactList();
    final sendList = [];

    for (var i in getList) {
      sendList.add(SecurityContactsModel.fromEntity(i).toJson());
    }

    if (params.getIndex() != -1) {
      sendList[params.getIndex()] = params.getUpdatedContact();
    }

    try {
      final response = await r.retry(
              () => dio.post('$apiUrl/security-contacts/${params.getUserId()}',
              options: Options(
                sendTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
              data: {'contacts': sendList}));

      return response.data['message'];
    } on DioException catch (e) {
      // Simplify
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
