import '../../../domain/models/crud_contacts_params.dart';

abstract class ContactsRemoteDatasource {
  Future<String> addSecurityContact(
      CRUDSecurityContactsParams params);

  Future<String> updateSecurityContact(
      CRUDSecurityContactsParams params);
}
