import 'package:flutter_bloc/flutter_bloc.dart';

import 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {

  //BudgetCubit(super(BudgetStateInitial));

  bool _isFetching = false;

  BudgetCubit(super.initialState);

  bool get isFetching => _isFetching;

  Future<void> getMyAllocatedBudget() async {
    try {

    } catch(e){
      emit(BudgetStateError());
    } finally {
      _isFetching = false;
    }
  }
}