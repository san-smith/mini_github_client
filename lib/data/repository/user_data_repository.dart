import 'package:mini_github_client/data/api/api_util.dart';
import 'package:mini_github_client/domain/model/commit.dart';
import 'package:mini_github_client/domain/model/repository.dart';
import 'package:mini_github_client/domain/model/user.dart';
import 'package:mini_github_client/domain/repository/user_repository.dart';

class UserDataRepository extends UserRepository {
  final ApiUtil _apiUtil;

  UserDataRepository(this._apiUtil);

  @override
  Future<User> getUser(String login) async {
    return await _apiUtil.getUser(login);
  }

  @override
  Future<List<Repository>> getRepos(String login) async {
    return await _apiUtil.getRepos(login);
  }

  @override
  Future<List<Commit>> getCommits(String login, String repo) async {
    return await _apiUtil.getCommits(login, repo);
  }
}