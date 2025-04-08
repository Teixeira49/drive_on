import 'package:drive_on/src/features/main_menu/domain/models/budget/budget_transaction_params.dart';

import '../../../../../shared/data/entities/user.dart';
import '../../../domain/models/budget/budget_transaction_dto.dart';
import '../../../domain/models/profile/profile_user_params.dart';
import '../../../domain/models/contacts/security_contacts_params.dart';
import '../../entities/security_contacts.dart';

abstract class MainMenuRemoteDatasource {
  Future<List<SecurityContacts>> getListSecurityContacts(
      SecurityContactsParams params);

  Future<User> getProfile(ProfileUserParams params);

  Future<BudgetTransactionsDTO> getWalletData(BudgetTransactionParams params);
}
