import 'package:mini_github_client/domain/model/commit.dart';
import 'package:mini_github_client/domain/model/repository.dart';
import 'package:mini_github_client/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getUser(String login);
  Future<List<Repository>> getRepos(String login);
  Future<List<Commit>> getCommits(String login, String repo);
}
