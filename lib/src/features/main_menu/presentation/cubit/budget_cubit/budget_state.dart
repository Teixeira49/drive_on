import '../../../data/entities/budget_wallet.dart';
import '../../../data/entities/transaction.dart';

abstract class BudgetState {}

class BudgetStateInitial extends BudgetState {}

class BudgetStateLoading extends BudgetState {}

class BudgetStateLoadedButEmpty extends BudgetState {
  final BudgetWallet wallet;
  final String message;

  BudgetStateLoadedButEmpty({required this.wallet, required this.message});
}

class BudgetStateLoaded extends BudgetState {
  final BudgetWallet wallet;
  final List<Transaction> history;

  BudgetStateLoaded({required this.wallet, required this.history});
}

class BudgetStateTimeout extends BudgetState {
  final String message;

  BudgetStateTimeout({required this.message});
}

class BudgetStateError extends BudgetState {
  final String message;

  BudgetStateError({required this.message});
}

class BudgetStateCatchError extends BudgetState {
  final String message;

  BudgetStateCatchError({required this.message});
}