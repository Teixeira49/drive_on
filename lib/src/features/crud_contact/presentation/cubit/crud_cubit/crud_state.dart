abstract class CRUDState {}

class CRUDStateInitial extends CRUDState {}

class CRUDStateLoading extends CRUDState {
  final String message;

  CRUDStateLoading({required this.message});
}

class CRUDStatePosted extends CRUDState {
  final String message;

  CRUDStatePosted({required this.message});
}

class CRUDStateTimeout extends CRUDState {
  final String message;

  CRUDStateTimeout({required this.message});
}

class CRUDStateError extends CRUDState {
  final String message;

  CRUDStateError({required this.message});
}

class CRUDStateCatchError extends CRUDState {
  final String message;

  CRUDStateCatchError({required this.message});
}