import '../../../../../shared/data/entities/user.dart';
import '../../../domain/models/profile_user_params.dart';
import '../../../domain/models/security_contacts_params.dart';
import '../../entities/security_contacts.dart';

abstract class MainMenuRemoteDatasource {
  Future<List<SecurityContacts>> getListSecurityContacts(SecurityContactsParams params);

  Future<User> getProfile(ProfileUserParams params);
}
