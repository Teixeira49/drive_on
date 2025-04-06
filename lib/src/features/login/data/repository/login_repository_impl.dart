import 'package:dartz/dartz.dart';

import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../domain/models/login_user_params.dart';
import '../../domain/repository/login_repository_abstract.dart';
import '../datasource/remote/login_datasource_impl.dart';
import '../../../../shared/data/entities/user.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasourceImpl loginDatasourceImpl;

  LoginRepositoryImpl(this.loginDatasourceImpl);

  @override
  Future<Either<Failure, User>> loginUser(UserParams params) async {
    try {
      final data = await loginDatasourceImpl.loginUser(params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(OtherFailure(e.toString()));
    }
  }
}
