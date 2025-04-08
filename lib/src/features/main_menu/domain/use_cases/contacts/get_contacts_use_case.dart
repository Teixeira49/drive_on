import 'package:dartz/dartz.dart';
import 'package:drive_on/src/core/network/error/failures.dart';
import 'package:drive_on/src/core/utils/usecases/usecase.dart';
import 'package:drive_on/src/shared/data/entities/security_contacts.dart';
import 'package:drive_on/src/features/main_menu/domain/models/contacts/security_contacts_get_params.dart';

import '../../repository/main_menu_repository_abst.dart';

class GetContactsUseCase
    extends UseCase<List<SecurityContacts>, SecurityContactsGetParams> {
  final MainMenuRepository repository;

  GetContactsUseCase(this.repository);

  @override
  Future<Either<Failure, List<SecurityContacts>>> call(
      SecurityContactsGetParams params) async {
    if (params.getUserId() == -1) {
      return Left(OtherFailure('Error al cargar cuenta', 'AccountException'));
    }
    final result = await repository.getSecurityContacts(params);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
