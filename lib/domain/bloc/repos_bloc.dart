import 'package:bloc/bloc.dart';
import 'package:mini_github_client/data/repository/user_data_repository.dart';
import 'package:mini_github_client/domain/model/repository.dart';

class ReposBloc extends Bloc<ReposEvent, ReposState> {
  final UserDataRepository _userDataRepository;

  ReposBloc(this._userDataRepository);

  @override
  ReposState get initialState => ReposInitState();

  @override
  Stream<ReposState> mapEventToState(ReposEvent event) async* {
    if (event is ReposGetEvent) {
      yield* _getReposToState(event.login);
    }
  }

  Stream<ReposState> _getReposToState(String login) async* {
    yield ReposLoadingState();
    try {
      var repos = await _userDataRepository.getRepos(login);
      yield ReposReadyState(repos);
    } catch (e) {
      yield ReposErrorState(e.message);
    }
  }
}

/// states

abstract class ReposState {}

class ReposInitState extends ReposState {}

class ReposLoadingState extends ReposState {}

class ReposReadyState extends ReposState {
  final List<Repository> repos;

  ReposReadyState(this.repos);
}

class ReposErrorState extends ReposState {
  final String message;

  ReposErrorState(this.message);
}

/// events

abstract class ReposEvent {}

class ReposGetEvent extends ReposEvent {
  final String login;

  ReposGetEvent(this.login);
}
