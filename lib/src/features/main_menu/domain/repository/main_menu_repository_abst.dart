import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/data/entities/user.dart';
import '../../data/entities/security_contacts.dart';
import '../models/profile_user_params.dart';
import '../models/security_contacts_params.dart';

abstract class MainMenuRepository {
  Future<Either<Failure, List<SecurityContacts>>> getSecurityContacts(
      SecurityContactsParams params);

  Future<Either<Failure, User>> getProfile(ProfileUserParams params);
}
