import 'package:mini_github_client/data/api/model/api_user.dart';

class ApiCommit {
  static const _SHA = 'sha';
  static const _COMMIT = 'commit';
  static const _MESSAGE = 'message';
  static const _AUTHOR = 'author';

  final String sha;
  final String message;
  final ApiUser author;

  ApiCommit.fromMap(Map<String, dynamic> map)
      : sha = map[_SHA],
        message = map[_COMMIT][_MESSAGE] ?? '',
        author = ApiUser.fromMap(map[_AUTHOR]);
}
