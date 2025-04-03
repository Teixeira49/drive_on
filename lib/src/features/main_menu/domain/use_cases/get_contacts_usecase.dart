import 'package:dartz/dartz.dart';
import 'package:drive_on/src/core/network/error/failures.dart';
import 'package:drive_on/src/core/utils/usecases/usecase.dart';
import 'package:drive_on/src/features/main_menu/data/entities/security_contacts.dart';
import 'package:drive_on/src/features/main_menu/domain/models/security_contacts_params.dart';

import '../repository/main_menu_repository_abst.dart';

class GetContactsUseCase
    extends UseCase<List<SecurityContacts>, SecurityContactsParams> {

  final MainMenuRepository repository;

  GetContactsUseCase(this.repository);

  @override
  Future<Either<Failure, List<SecurityContacts>>> call(
      SecurityContactsParams params) async {
    final result = await repository.getSecurityContacts(params.userId);
    return result.fold(
            (l) => Left(l),
            (r) => Right(r)
    );
  }


}