import '../../../data/entities/budget_wallet.dart';
import '../../../data/entities/transaction.dart';

abstract class BudgetState {}

class BudgetStateInitial extends BudgetState {}

class BudgetStateLoading extends BudgetState {}

class BudgetStateLoaded extends BudgetState {
  final BudgetWallet wallet;
  final List<Transaction> history;

  BudgetStateLoaded({required this.wallet, required this.history});
}

class BudgetStateTimeout extends BudgetState {
  final String sms;

  BudgetStateTimeout({required this.sms});
}

class BudgetStateError extends BudgetState {
  final String sms;

  BudgetStateError({required this.sms});
}

class BudgetStateCatchError extends BudgetState {
  final String sms;

  BudgetStateCatchError({required this.sms});
}