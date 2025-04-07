import '../../../data/entities/budget_wallet.dart';

class BudgetModel extends BudgetWallet {
  BudgetModel({
    required super.userId,
    required super.department,
    required super.assigned,
    required super.used,
    required super.lastUpdated,
  });

  factory BudgetModel.fromJson(json) {
    return BudgetModel(
      userId: json['userId'],
      department: json['department'],
      assigned: json['assigned'],
      used: json['used'],
      lastUpdated: json['lastUpdated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'department': department,
      'assigned': assigned,
      'used': used,
      'lastUpdated': lastUpdated,
    };
  }

  factory BudgetModel.fromEntity(BudgetWallet budget) {
    return BudgetModel(
      userId: budget.userId,
      department: budget.department,
      assigned: budget.assigned,
      used: budget.used,
      lastUpdated: budget.lastUpdated,
    );
  }
}
