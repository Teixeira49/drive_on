class BudgetWallet {
  int userId;
  String department;
  double assigned;
  double used;
  String lastUpdated;

  BudgetWallet(
      {required this.userId,
      required this.department,
      required this.assigned,
      required this.used,
      required this.lastUpdated});
}
