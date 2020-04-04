import 'package:mini_github_client/data/api/mapper/commit_mapper.dart';
import 'package:mini_github_client/data/api/mapper/repository_mapper.dart';
import 'package:mini_github_client/data/api/mapper/user_mapper.dart';
import 'package:mini_github_client/data/api/service/rest_service.dart';
import 'package:mini_github_client/domain/model/commit.dart';
import 'package:mini_github_client/domain/model/repository.dart';
import 'package:mini_github_client/domain/model/user.dart';

class ApiUtil {
  final RestService _restService;

  ApiUtil(this._restService);

  Future<User> getUser(String login) async {
    var user = await _restService.getUser(login);
    return UserMapper.fromApi(user);
  }

  Future<List<Repository>> getRepos(String login) async {
    final repos = await _restService.getRepos(login);
    return repos.map((item) => RepositoryMapper.fromApi(item)).toList();
  }

  Future<List<Commit>> getComits(String login, String repo) async {
    final repos = await _restService.getCommits(login, repo);
    return repos.map((item) => CommitMapper.fromApi(item)).toList();
  }
}
