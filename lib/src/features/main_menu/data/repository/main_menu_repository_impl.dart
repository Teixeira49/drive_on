import 'package:dartz/dartz.dart';


import '../../../../core/network/error/failures.dart';
import '../../domain/models/security_contacts_params.dart';
import '../../domain/repository/main_menu_repository_abst.dart';
import '../datasource/remote/main_menu_datasource_abst.dart';
import '../entities/security_contacts.dart';

class MainMenuRepositoryImpl extends MainMenuRepository {

  final MainMenuRemoteDatasource mainMenuRemoteDatasource;

  MainMenuRepositoryImpl(this.mainMenuRemoteDatasource);

  @override
  Future<Either<Failure, List<SecurityContacts>>> getSecurityContacts(SecurityContactsParams params) async {

    try {
      final data = await mainMenuRemoteDatasource.getListSecurityContacts(params);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }

  }

}