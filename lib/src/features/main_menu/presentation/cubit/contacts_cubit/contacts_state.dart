import 'package:drive_on/src/shared/data/entities/security_contacts.dart';

abstract class ContactsState {}

class ContactsStateInitial extends ContactsState {}

class ContactsStateLoading extends ContactsState {}

class ContactsStateLoaded extends ContactsState {
  final List<SecurityContacts> securityContacts;

  ContactsStateLoaded({required this.securityContacts});
}

class ContactsStateLoadedButEmpty extends ContactsState {
  final String message;

  ContactsStateLoadedButEmpty({required this.message});
}


class ContactsStateErrorLoading extends ContactsState {
  final String message;

  ContactsStateErrorLoading({required this.message});
}

class ContactsStateError extends ContactsState {
  final String message;

  ContactsStateError({required this.message});
}

class ContactsStateCatchError extends ContactsState {
  final String message;

  ContactsStateCatchError({required this.message});
}