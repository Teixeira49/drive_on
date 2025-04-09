import '../../data/entities/security_contacts.dart';

class SecurityContactsModel extends SecurityContacts {
  SecurityContactsModel({
    required super.name,
    required super.phone,
    required super.relationship,
  });

  factory SecurityContactsModel.fromJson(json) {
    return SecurityContactsModel(
      name: json['name'],
      phone: json['phone'],
      relationship: json['relationship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'relationship': relationship,
    };
  }

  factory SecurityContactsModel.fromEntity(SecurityContacts contact) {
    return SecurityContactsModel(
      name: contact.name,
      phone: contact.phone,
      relationship: contact.relationship,
    );
  }
}
