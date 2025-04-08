import 'package:dartz/dartz.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../../../core/utils/usecases/usecase.dart';
import '../../models/budget/budget_transaction_dto.dart';
import '../../models/budget/budget_transaction_params.dart';
import '../../repository/main_menu_repository_abst.dart';

class GetBudgetUseCase
    extends UseCase<BudgetTransactionsDTO, BudgetTransactionParams> {

  final MainMenuRepository repository;

  GetBudgetUseCase(this.repository);

  @override
  Future<Either<Failure, BudgetTransactionsDTO>> call(
      BudgetTransactionParams params) async {
    if (params.getUserId() == -1) {
      return Left(OtherFailure('Error al cargar cuenta', 'AccountException'));
    }
    final result = await repository.getWalletData(params);
    return result.fold(
            (l) => Left(l),
            (r) => Right(r)
    );
  }
}