import 'package:drive_on/src/features/main_menu/domain/models/budget/budget_transaction_params.dart';

import '../../../../../shared/data/entities/user.dart';
import '../../../domain/models/budget/budget_transaction_dto.dart';
import '../../../domain/models/contacts/security_contacts_delete_params.dart';
import '../../../domain/models/profile/profile_user_params.dart';
import '../../../domain/models/contacts/security_contacts_get_params.dart';
import '../../entities/security_contacts.dart';

abstract class MainMenuRemoteDatasource {
  Future<List<SecurityContacts>> getListSecurityContacts(
      SecurityContactsGetParams params);

  Future<String> deleteListSecurityContacts(
      SecurityContactsDeleteParams params);

  Future<User> getProfile(ProfileUserParams params);

  Future<BudgetTransactionsDTO> getWalletData(BudgetTransactionParams params);
}
