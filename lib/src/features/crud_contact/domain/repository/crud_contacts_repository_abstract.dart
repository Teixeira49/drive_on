import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../models/crud_contacts_params.dart';

abstract class CRUDContactsRepository {
  Future<Either<Failure, String>> getSecurityContacts(
      CRUDSecurityContactsParams params);

  Future<Either<Failure, String>> updateSecurityContacts(
      CRUDSecurityContactsParams params);
}
