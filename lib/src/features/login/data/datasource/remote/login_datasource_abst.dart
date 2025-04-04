import '../../../domain/models/login_user_params.dart';
import '../../entities/user.dart';

abstract class LoginDatasource {
  Future<User> loginUser(UserParams params);
}