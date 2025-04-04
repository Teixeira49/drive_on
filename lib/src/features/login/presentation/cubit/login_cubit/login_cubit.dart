import 'package:drive_on/src/features/login/domain/use_cases/login_account_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/login_user_params.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginAccountUseCase accountUseCase;

  bool _isFetching = false;

  LoginCubit(this.accountUseCase) : super(LoginStateInitial());

  bool get isFetching => _isFetching;

  Future<void> loginAccount(String email, String password) async {
    try {
      emit(LoginStateLoading());
      final data = await accountUseCase
          .call(UserParams(email: email, password: password));
      data.fold(
              (l) => emit(LoginStateLoadedButNotLog()),
              (r) => emit(LoginStateLoaded())
      );
    } catch (e) {
      emit(LoginStateError());
    } finally {
      _isFetching = false;
    }
  }
}
