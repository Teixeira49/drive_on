import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../data/entities/security_contacts.dart';
import '../models/security_contacts_params.dart';

abstract class MainMenuRepository {
  Future<Either<Failure, List<SecurityContacts>>> getSecurityContacts(
      SecurityContactsParams params);
}
