import 'package:mini_github_client/domain/bloc/user_bloc.dart';
import 'package:mini_github_client/internal/dependencies/repository_module.dart';

class UserModule {
  static UserBloc userBloc() {
    return UserBloc(
      RepositoryModule.userRepository(),
    );
  }
}
