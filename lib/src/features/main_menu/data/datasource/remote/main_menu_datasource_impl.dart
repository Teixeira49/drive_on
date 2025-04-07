import 'package:dio/dio.dart';
import 'package:drive_on/src/features/main_menu/domain/models/budget/budget_transaction_params.dart';
import 'package:drive_on/src/features/main_menu/domain/models/budget/transaction_model.dart';
import 'package:retry/retry.dart';

import '../../../../../core/network/error/dio_error_handler.dart';
import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/network/network_url.dart';
import '../../../../../shared/data/entities/user.dart';
import '../../../domain/models/budget/budget_model.dart';
import '../../../domain/models/budget/budget_transaction_dto.dart';
import '../../../domain/models/profile/profile_user_model.dart';
import '../../../domain/models/profile/profile_user_params.dart';
import '../../../domain/models/contacts/security_contacts_model.dart';
import '../../../domain/models/contacts/security_contacts_params.dart';
import '../../entities/security_contacts.dart';
import 'main_menu_datasource_abst.dart';

class MainMenuRemoteDatasourceImpl implements MainMenuRemoteDatasource {
  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<List<SecurityContacts>> getListSecurityContacts(
      SecurityContactsParams params) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    print(params.getUserId());

    try {
      final response = await r.retry(() => dio.get(
            '$apiUrl/security-contacts/${params.getUserId()}',
            options: Options(
              sendTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          ));
      final items = (response.data as List)
          .map((item) => SecurityContactsModel.fromJson(item))
          .toList();
      return items;
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
  Future<User> getProfile(ProfileUserParams params) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    try {
      final response = await r.retry(() => dio.get(
            '$apiUrl/profile/${params.getUserId()}',
            options: Options(
              sendTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          ));

      return UserModel.fromJson(response.data);
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
  Future<BudgetTransactionsDTO> getWalletData(
      BudgetTransactionParams params) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    try {
      final response = await r.retry(() => dio.get(
            '$apiUrl/budget/${params.getUserId()}',
            options: Options(
              sendTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          ));

      final items = (response.data["history"] as List)
          .map((item) => TransactionModel.fromJson(item))
          .toList();

      return BudgetTransactionsDTO(
          budgetWallet: BudgetModel.fromJson(response.data),
          transactions: items);
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
