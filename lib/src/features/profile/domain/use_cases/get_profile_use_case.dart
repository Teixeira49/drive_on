

import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../../../shared/data/entities/user.dart';
import '../models/profile_user_params.dart';
import '../repository/profile_repository_abstract.dart';

class GetProfileUseCase extends UseCase<User, ProfileUserParams> {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(ProfileUserParams params) async {
    final result = await repository.getProfile(params);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
