import 'package:dartz/dartz.dart';
import 'package:drive_on/src/core/network/error/failures.dart';
import 'package:drive_on/src/features/crud_contact/domain/models/crud_contacts_params.dart';
import 'package:drive_on/src/features/crud_contact/domain/repository/crud_contacts_repository_abstract.dart';

import '../datasource/remote/crud_contacts_datasource_abstract.dart';

class CRUDContactsRepositoryImpl extends CRUDContactsRepository {

  final ContactsRemoteDatasource contactsRemoteDatasource;

  CRUDContactsRepositoryImpl(this.contactsRemoteDatasource);

  @override
  Future<Either<Failure, String>> getSecurityContacts(
      CRUDSecurityContactsParams params) async {
    try {
      final data =
          await contactsRemoteDatasource.addSecurityContact(params);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, String>> updateSecurityContacts(
      CRUDSecurityContactsParams params) async {
    try {
      final data =
          await contactsRemoteDatasource.updateSecurityContact(params);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
