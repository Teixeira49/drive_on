
abstract class ContactsState {}

class ContactsStateInitial extends ContactsState {}

class ContactsStateLoading extends ContactsState {}

class ContactsStateLoaded extends ContactsState {}

class ContactsStateLoadedButEmpty extends ContactsState {}

class ContactsStateError extends ContactsState {}
