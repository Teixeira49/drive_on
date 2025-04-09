import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/budget/budget_transaction_params.dart';
import '../../../domain/use_cases/budget/get_budget_use_case.dart';
import 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final GetBudgetUseCase getBudgetUseCase;

  bool _isFetching = false;

  BudgetCubit(this.getBudgetUseCase) : super(BudgetStateInitial());

  bool get isFetching => _isFetching;

  Future<void> getWalletAndHistory(int id) async {
    try {
      emit(BudgetStateLoading());
      final data = await getBudgetUseCase.call(BudgetTransactionParams(id: id));
      data.fold(
          (l) => emit(selectErrorState(l.failType ?? '', l.message)),
          (r) => r.transactions.isNotEmpty
              ? emit(BudgetStateLoaded(
                  wallet: r.budgetWallet, history: r.transactions))
              : emit(BudgetStateLoadedButEmpty(
                  wallet: r.budgetWallet,
                  message: 'No posee Transacciones Recientes')));
    } catch (e) {
      emit(BudgetStateCatchError(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}

BudgetState selectErrorState(String state, String message) {
  switch (state) {
    case "AccountException":
      return BudgetStateError(message: message);
    case "ServerException":
      return BudgetStateError(message: message);
    case "":
      return BudgetStateError(message: message);
    default:
      return BudgetStateCatchError(message: message);
  }
}
