import 'package:drive_on/src/shared/data/entities/security_contacts.dart';

class CRUDSecurityContactsParams {
  CRUDSecurityContactsParams(
      {required this.newList,
      required this.name,
      required this.phone,
      this.relationship,
      required this.userId});

  List<SecurityContacts> newList;
  String name;
  String phone;
  String? relationship;
  int userId;

  List<SecurityContacts> getContactList() {
    return newList;
  }

  int getUserId() {
    return userId;
  }
}
