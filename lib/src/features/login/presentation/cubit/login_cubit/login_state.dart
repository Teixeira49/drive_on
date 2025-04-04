abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {}

class LoginStateLoadedButNotLog extends LoginState {}

class LoginStateLoadedButEmpty extends LoginState {}

class LoginStateError extends LoginState {}
