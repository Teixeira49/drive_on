
import '../../../data/entities/user.dart';

class UserState {
  final User? user;

  UserState({this.user});

  UserState copyWith({User? user}) {
    return UserState(user: user ?? this.user);
  }
}