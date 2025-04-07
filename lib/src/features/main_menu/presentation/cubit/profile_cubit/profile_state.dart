
import '../../../../../shared/data/entities/user.dart';

abstract class ProfileState {}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateLoaded extends ProfileState {
  final User user;

  ProfileStateLoaded({required this.user});
}

class ProfileStateTimeout extends ProfileState {
  final String sms;

  ProfileStateTimeout({required this.sms});
}

class ProfileStateError extends ProfileState {
  final String sms;

  ProfileStateError({required this.sms});
}

class ProfileStateCatchError extends ProfileState {
  final String sms;

  ProfileStateCatchError({required this.sms});
}