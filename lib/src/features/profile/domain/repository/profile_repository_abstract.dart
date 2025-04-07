import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/data/entities/user.dart';
import '../models/profile_user_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getProfile(ProfileUserParams params);
}
