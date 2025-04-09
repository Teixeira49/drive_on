import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../models/crud_contacts_params.dart';
import '../repository/crud_contacts_repository_abstract.dart';

class AddContactUseCase extends UseCase<String, CRUDSecurityContactsParams> {
  final CRUDContactsRepository repository;

  AddContactUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(
      CRUDSecurityContactsParams params) async {
    if (params.getUserId() == -1) {
      return Left(OtherFailure('Error al cargar cuenta', 'AccountException'));
    }
    final result = await repository.getSecurityContacts(params);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
