import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../../../shared/data/entities/user.dart';
import '../models/login_user_params.dart';
import '../repository/login_repository_abstract.dart';

class LoginAccountUseCase extends UseCase<User, UserParams> {
  final LoginRepository repository;

  LoginAccountUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UserParams params) async {
    final result = await repository.loginUser(params);
    print(result.fold((l) => l, (r) => r.userEmail));
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
