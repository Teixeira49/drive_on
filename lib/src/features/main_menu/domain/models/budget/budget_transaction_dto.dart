import '../../../data/entities/budget_wallet.dart';
import '../../../data/entities/transaction.dart';

class BudgetTransactionsDTO {
  final BudgetWallet budgetWallet;
  final List<Transaction> transactions;

  BudgetTransactionsDTO(
      {required this.budgetWallet, required this.transactions});
}
