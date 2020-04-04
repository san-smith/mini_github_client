import 'package:mini_github_client/data/api/mapper/user_mapper.dart';
import 'package:mini_github_client/data/api/model/api_commit.dart';
import 'package:mini_github_client/domain/model/commit.dart';

class CommitMapper {
  static Commit fromApi(ApiCommit commit) {
    return Commit(
      sha: commit.sha,
      message: commit.message,
      author: UserMapper.fromApi(commit.author),
    );
  }
}
