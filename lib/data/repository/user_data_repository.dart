import 'package:mini_github_client/data/api/api_util.dart';
import 'package:mini_github_client/domain/model/user.dart';
import 'package:mini_github_client/domain/repository/user_repository.dart';

class UserDataRepository extends UserRepository {
  final ApiUtil _apiUtil;

  UserDataRepository(this._apiUtil);

  @override
  Future<User> getUser(login) async {
    return await _apiUtil.getUser(login);
  }
}