import 'package:mini_github_client/data/api/model/api_repository.dart';
import 'package:mini_github_client/domain/model/repository.dart';

class RepositoryMapper {
  static Repository fromApi(ApiRepository rep) {
    return Repository(
      description: rep.description,
      language: rep.language,
      name: rep.name,
      stargazersCount: rep.stargazersCount,
    );
  }
}
