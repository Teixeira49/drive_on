import 'package:dartz/dartz.dart';

import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../shared/data/entities/user.dart';
import '../../domain/models/profile_user_params.dart';
import '../../domain/repository/profile_repository_abstract.dart';
import '../datasource/remote/profile_datasource_impl.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDatasourceImpl profileRemoteDatasourceImpl;

  ProfileRepositoryImpl(this.profileRemoteDatasourceImpl);

  @override
  Future<Either<Failure, User>> getProfile(ProfileUserParams params) async {
    try {
      final data = await profileRemoteDatasourceImpl.getProfile(params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, 'ServerException'));
    } catch (e) {
      return Left(OtherFailure(e.toString(), null));
    }
  }
}
