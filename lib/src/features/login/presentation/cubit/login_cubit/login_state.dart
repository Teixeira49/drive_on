import '../../../data/entities/user.dart';

abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoginSuccess extends LoginState {
  final User user;

  LoginStateLoginSuccess({required this.user});
}

class LoginStateLoginFailed extends LoginState {
  final String sms;

  LoginStateLoginFailed({required this.sms});
}

class LoginStateError extends LoginState {
  final String sms;

  LoginStateError({required this.sms});
}
