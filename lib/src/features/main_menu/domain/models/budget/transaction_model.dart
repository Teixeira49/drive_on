import '../../../data/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.operation,
    required super.date,
    required super.byT,
    required super.forT,
  });

  factory TransactionModel.fromJson(json) {
    return TransactionModel(
      operation: json['operation'],
      date: json['date'],
      byT: json['by'],
      forT: json['for'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'operation': operation,
      'date': date,
      'by': byT,
      'for': forT,
    };
  }

  factory TransactionModel.fromEntity(Transaction trans) {
    return TransactionModel(
      operation: trans.operation,
      date: trans.date,
      byT: trans.byT,
      forT: trans.forT,
    );
  }
}
