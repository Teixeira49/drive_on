import 'package:drive_on/src/features/main_menu/data/entities/security_contacts.dart';

class SecurityContactsDeleteParams {

  SecurityContactsDeleteParams({required this.newList, required this.userId});

  List<SecurityContacts> newList;
  int userId;

  List<SecurityContacts> getContactList () {
    return newList;
  }

  int getUserId() {
    return userId;
  }
}