import 'package:mini_github_client/data/api/model/api_user.dart';
import 'package:mini_github_client/domain/model/user.dart';

class UserMapper {
  static User fromApi(ApiUser user) {
    return User(
      id: user.id,
      avatarUrl: user.avatarUrl,
      login: user.login,
      name: user.name,
      publicRepos: user.publicRepos,
      location: user.location,
      bio: user.bio,
    );
  }
}
