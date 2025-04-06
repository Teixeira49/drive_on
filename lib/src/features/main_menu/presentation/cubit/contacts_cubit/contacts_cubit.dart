import 'package:drive_on/src/features/main_menu/domain/use_cases/get_contacts_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/error_constants.dart';
import '../../../domain/models/security_contacts_params.dart';
import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final GetContactsUseCase getContactsUseCase;

  bool _isFetching = false;

  ContactsCubit(this.getContactsUseCase) : super(ContactsStateInitial());

  bool get isFetching => _isFetching;

  Future<void> getMyAllocatedContacts(int userId) async {
    try {
      emit(ContactsStateLoading());
      final data =
          await getContactsUseCase.call(SecurityContactsParams(userId: userId));
      data.fold(
          (l) => l.failType == 'AccountException'
              ? emit(ContactsStateErrorLoading(message: l.message))
              : emit(ContactsStateError(message: l.message)),
          (r) => r.isNotEmpty
              ? ContactsStateLoaded(securityContacts: r)
              : ContactsStateLoadedButEmpty(message: emptyContactList));
    } catch (e) {
      emit(ContactsStateCatchError(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}