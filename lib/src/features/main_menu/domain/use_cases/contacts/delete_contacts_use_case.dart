import 'package:dartz/dartz.dart';
import 'package:drive_on/src/core/network/error/failures.dart';
import 'package:drive_on/src/core/utils/usecases/usecase.dart';
import '../../models/contacts/security_contacts_delete_params.dart';
import '../../repository/main_menu_repository_abst.dart';

class DeleteContactsUseCase
    extends UseCase<String, SecurityContactsDeleteParams> {
  final MainMenuRepository repository;

  DeleteContactsUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(
      SecurityContactsDeleteParams params) async {
    final result = await repository.deleteSecurityContacts(params);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}