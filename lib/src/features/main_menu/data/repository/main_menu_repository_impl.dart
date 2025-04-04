import 'package:dartz/dartz.dart';


import '../../../../core/network/error/failures.dart';
import '../../domain/repository/main_menu_repository_abst.dart';
import '../datasource/remote/main_menu_datasource_impl.dart';
import '../entities/security_contacts.dart';

class MainMenuRepositoryImpl extends MainMenuRepository {

  final MainMenuRemoteDatasourceImpl mainMenuRemoteDatasourceImpl;

  MainMenuRepositoryImpl(this.mainMenuRemoteDatasourceImpl);

  @override
  Future<Either<Failure, List<SecurityContacts>>> getSecurityContacts(int userId) async {

    try {
      final data = await mainMenuRemoteDatasourceImpl.getListSecurityContacts(userId);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }

  }

}