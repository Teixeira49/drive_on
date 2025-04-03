import '../../data/entities/security_contacts.dart';

class SecurityContactsModel extends SecurityContacts {
  SecurityContactsModel({
    required super.name,
    required super.number,
    required super.relationship,
  });

  factory SecurityContactsModel.fromJson(json) {
    return SecurityContactsModel(
      name: json['name'],
      number: json['number'],
      relationship: json['relationship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'relationship': relationship,
    };
  }

  factory SecurityContactsModel.fromEntity(SecurityContacts contact) {
    return SecurityContactsModel(
      name: contact.name,
      number: contact.number,
      relationship: contact.relationship,
    );
  }
}
