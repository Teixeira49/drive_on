import '../../entities/security_contacts.dart';

abstract class MainMenuRemoteDatasource {
  Future<List<SecurityContacts>> getListSecurityContacts(int userId);
}
