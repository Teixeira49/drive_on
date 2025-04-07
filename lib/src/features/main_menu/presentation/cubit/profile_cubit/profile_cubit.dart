
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main_menu/domain/models/profile_user_params.dart';
import '../../../../main_menu/domain/use_cases/get_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  bool _isFetching = false;

  ProfileCubit(this.getProfileUseCase) : super(ProfileStateInitial());

  bool get isFetching => _isFetching;

  Future<void> getProfile(int id) async {
    try {
      emit(ProfileStateLoading());
      print('a');
      final data = await getProfileUseCase
          .call(ProfileUserParams(id: id));
      data.fold(
              (l) => emit(selectErrorState(l.failType ?? '', l.message)),
              (r) => emit(ProfileStateLoaded(user: r))
      );
    } catch (e) {
      emit(ProfileStateCatchError(sms: e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}

ProfileState selectErrorState(String state, String message) {
  switch (state) {
    case "AccountException":
      return ProfileStateError(sms: message);
    case "ServerException":
      return ProfileStateError(sms: message);
    case "":
      return ProfileStateError(sms: message);
    default:
      return ProfileStateCatchError(sms: message);
  }
}
