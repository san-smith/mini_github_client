import 'package:mini_github_client/data/repository/user_data_repository.dart';
import 'package:mini_github_client/domain/repository/user_repository.dart';
import 'api_module.dart';

class RepositoryModule {
  static UserRepository _userRepository;

  static UserRepository userRepository() {
    if (_userRepository == null) {
      _userRepository = UserDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _userRepository;
  }
}
