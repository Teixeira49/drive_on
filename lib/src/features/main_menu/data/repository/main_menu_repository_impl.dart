import 'package:dartz/dartz.dart';
import 'package:drive_on/src/features/main_menu/domain/models/budget/budget_transaction_dto.dart';
import 'package:drive_on/src/features/main_menu/domain/models/budget/budget_transaction_params.dart';
import 'package:drive_on/src/features/main_menu/domain/models/contacts/security_contacts_delete_params.dart';


import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../shared/data/entities/user.dart';
import '../../domain/models/profile/profile_user_params.dart';
import '../../domain/models/contacts/security_contacts_get_params.dart';
import '../../domain/repository/main_menu_repository_abst.dart';
import '../datasource/remote/main_menu_datasource_abst.dart';
import '../../../../shared/data/entities/security_contacts.dart';

class MainMenuRepositoryImpl extends MainMenuRepository {

  final MainMenuRemoteDatasource mainMenuRemoteDatasource;

  MainMenuRepositoryImpl(this.mainMenuRemoteDatasource);

  @override
  Future<Either<Failure, List<SecurityContacts>>> getSecurityContacts(SecurityContactsGetParams params) async {
    try {
      final data = await mainMenuRemoteDatasource.getListSecurityContacts(params);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, String>> deleteSecurityContacts(SecurityContactsDeleteParams params) async {
    try {
      final data = await mainMenuRemoteDatasource.deleteListSecurityContacts(params);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, User>> getProfile(ProfileUserParams params) async {
    try {
      final data = await mainMenuRemoteDatasource.getProfile(params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, 'ServerException'));
    } catch (e) {
      return Left(OtherFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, BudgetTransactionsDTO>> getWalletData(BudgetTransactionParams params) async {
    try {
      final data = await mainMenuRemoteDatasource.getWalletData(params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, 'ServerException'));
    } catch (e) {
      return Left(OtherFailure(e.toString(), null));
    }
  }
}