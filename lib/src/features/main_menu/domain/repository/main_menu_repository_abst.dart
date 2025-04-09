import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/data/entities/user.dart';
import '../../../../shared/data/entities/security_contacts.dart';
import '../models/budget/budget_transaction_dto.dart';
import '../models/budget/budget_transaction_params.dart';
import '../models/contacts/security_contacts_delete_params.dart';
import '../models/profile/profile_user_params.dart';
import '../models/contacts/security_contacts_get_params.dart';

abstract class MainMenuRepository {
  Future<Either<Failure, List<SecurityContacts>>> getSecurityContacts(
      SecurityContactsGetParams params);

  Future<Either<Failure, String>> deleteSecurityContacts(
      SecurityContactsDeleteParams params);

  Future<Either<Failure, User>> getProfile(ProfileUserParams params);

  Future<Either<Failure, BudgetTransactionsDTO>> getWalletData(
      BudgetTransactionParams params);
}
