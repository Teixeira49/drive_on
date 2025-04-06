import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {

  //ContactsCubit(super(ContactsStateInitial));

  bool _isFetching = false;

  ContactsCubit(super.initialState);

  bool get isFetching => _isFetching;

  Future<void> getMyAllocatedContacts() async {
    try {

    } catch(e){
      emit(ContactsStateError());
    } finally {
      _isFetching = false;
    }
  }
}