import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/data/entities/user.dart';
import '../models/login_user_params.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> loginUser(UserParams params);
}
