import 'package:mini_github_client/domain/model/user.dart';

class Commit {
  final String sha;
  final String message;
  final User author;

  Commit({
    this.sha,
    this.message,
    this.author,
  });
}
