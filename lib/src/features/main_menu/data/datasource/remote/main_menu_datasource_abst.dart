import '../../../domain/models/security_contacts_params.dart';
import '../../entities/security_contacts.dart';

abstract class MainMenuRemoteDatasource {
  Future<List<SecurityContacts>> getListSecurityContacts(SecurityContactsParams params);
}
