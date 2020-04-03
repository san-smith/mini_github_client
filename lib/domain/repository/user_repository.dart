import 'package:mini_github_client/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getUser(login);
}
