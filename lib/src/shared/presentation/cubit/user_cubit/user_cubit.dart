import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entities/user.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {

  UserCubit() : super(UserState());

  User? getUser() {
    return (state.user);
  }

  void updateUser(User user) async {
    emit(state.copyWith(user: user));
  }

  // Add Delete user
}