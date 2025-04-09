import 'package:drive_on/src/features/crud_contact/domain/models/crud_contacts_params.dart';
import 'package:drive_on/src/shared/data/entities/security_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/add_contact_use_case.dart';
import '../../../domain/use_cases/update_contact_use_case.dart';
import 'crud_state.dart';

class CRUDCubit extends Cubit<CRUDState> {
  final AddContactUseCase addContactUseCase;
  final UpdateContactUseCase updateContactUseCase;

  bool _isFetching = false;

  CRUDCubit(this.addContactUseCase, this.updateContactUseCase)
      : super(CRUDStateInitial());

  bool get isFetching => _isFetching;

  Future<void> addContact(List<SecurityContacts> contacts, String name,
      String phone, String? relationship, int id) async {
    try {
      emit(CRUDStateLoading(message: 'Agregando Contacto'));
      final data = await addContactUseCase.call(CRUDSecurityContactsParams(
          newList: contacts,
          userId: id,
          name: name,
          phone: phone,
          relationship: relationship));
      data.fold((l) => emit(selectErrorState(l.failType ?? '', l.message)),
          (r) => emit(CRUDStatePosted(message: r)));
    } catch (e) {
      emit(CRUDStateCatchError(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> updateContact(List<SecurityContacts> contacts, String name,
      String phone, String? relationship, int id, int index) async {
    try {
      emit(CRUDStateLoading(message: 'Actualizando Contacto'));
      final data = await updateContactUseCase.call(CRUDSecurityContactsParams(
          newList: contacts,
          userId: id,
          name: name,
          phone: phone,
          relationship: relationship,
          index: index));
      data.fold((l) => emit(selectErrorState(l.failType ?? '', l.message)),
          (r) => emit(CRUDStatePosted(message: r)));
    } catch (e) {
      emit(CRUDStateCatchError(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}

CRUDState selectErrorState(String state, String message) {
  switch (state) {
    case "AccountException":
      return CRUDStateError(message: message);
    case "ServerException":
      return CRUDStateError(message: message);
    case "":
      return CRUDStateTimeout(message: message);
    default:
      return CRUDStateCatchError(message: message);
  }
}
