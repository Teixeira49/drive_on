import 'package:drive_on/src/features/main_menu/domain/use_cases/contacts/delete_contacts_use_case.dart';
import 'package:drive_on/src/features/main_menu/domain/use_cases/contacts/get_contacts_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/error_constants.dart';
import '../../../../../shared/data/entities/security_contacts.dart';
import '../../../domain/models/contacts/security_contacts_delete_params.dart';
import '../../../domain/models/contacts/security_contacts_get_params.dart';
import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final GetContactsUseCase getContactsUseCase;
  final DeleteContactsUseCase deleteContactsUseCase;

  bool _isFetching = false;

  ContactsCubit(this.getContactsUseCase, this.deleteContactsUseCase)
      : super(ContactsStateInitial());

  bool get isFetching => _isFetching;

  Future<void> getMyAllocatedContacts(int userId) async {
    try {
      emit(ContactsStateLoading());
      final data = await getContactsUseCase
          .call(SecurityContactsGetParams(userId: userId));
      data.fold(
          (l) => l.failType == 'AccountException'
              ? emit(ContactsStateErrorLoading(message: l.message))
              : emit(ContactsStateError(message: l.message)),
          (r) => r.isNotEmpty
              ? emit(ContactsStateLoaded(securityContacts: r))
              : emit(ContactsStateLoadedButEmpty(message: emptyContactList)));
    } catch (e) {
      emit(ContactsStateCatchError(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> deleteContact(List<SecurityContacts> contacts, int id, int userId) async {
    try {
      emit(ContactsStateLoading());
      final copyContacts = contacts;
      contacts.removeAt(id);
      final data = await deleteContactsUseCase
          .call(SecurityContactsDeleteParams(newList: contacts, userId: userId));
      data.fold(
          (l) => emit(ContactsStateLoaded(securityContacts: copyContacts)),
          (r) => emit(ContactsStateLoaded(securityContacts: contacts)));
    } catch (e) {
      emit(ContactsStateCatchError(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}