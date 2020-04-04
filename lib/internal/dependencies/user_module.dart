import 'package:mini_github_client/domain/bloc/commits_bloc.dart';
import 'package:mini_github_client/domain/bloc/repos_bloc.dart';
import 'package:mini_github_client/domain/bloc/user_bloc.dart';
import 'package:mini_github_client/internal/dependencies/repository_module.dart';

class UserModule {
  static UserBloc userBloc() {
    return UserBloc(
      RepositoryModule.userRepository(),
    );
  }

  static ReposBloc reposBloc() {
    return ReposBloc(
      RepositoryModule.userRepository(),
    );
  }

  static CommitsBloc commitsBloc() {
    return CommitsBloc(
      RepositoryModule.userRepository(),
    );
  }
}
