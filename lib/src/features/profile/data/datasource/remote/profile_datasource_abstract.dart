import '../../../../../shared/data/entities/user.dart';
import '../../../domain/models/profile_user_params.dart';

abstract class ProfileRemoteDatasource {
  Future<User> getProfile(ProfileUserParams params);
}
