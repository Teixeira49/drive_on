
abstract class BudgetState {}

class BudgetStateInitial extends BudgetState {}

class BudgetStateLoading extends BudgetState {}

class BudgetStateLoaded extends BudgetState {}

class BudgetStateLoadedButEmpty extends BudgetState {}

class BudgetStateError extends BudgetState {}
