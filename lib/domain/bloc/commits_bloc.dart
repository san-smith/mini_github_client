import 'package:bloc/bloc.dart';
import 'package:mini_github_client/data/repository/user_data_repository.dart';
import 'package:mini_github_client/domain/model/commit.dart';

class CommitsBloc extends Bloc<CommitsEvent, CommitsState> {
  final UserDataRepository _userDataRepository;

  CommitsBloc(this._userDataRepository);

  @override
  CommitsState get initialState => CommitsInitState();

  @override
  Stream<CommitsState> mapEventToState(CommitsEvent event) async* {
    if (event is CommitsGetEvent) {
      yield* _getCommitsToState(event.login, event.repo);
    }
  }

  Stream<CommitsState> _getCommitsToState(String login, String repo) async* {
    yield CommitsLoadingState();
    try {
      var commits = await _userDataRepository.getCommits(login, repo);
      yield CommitsReadyState(commits);
    } catch (e) {
      yield CommitsErrorState(e.message);
    }
  }
}

/// states

abstract class CommitsState {}

class CommitsInitState extends CommitsState {}

class CommitsLoadingState extends CommitsState {}

class CommitsReadyState extends CommitsState {
  final List<Commit> commits;

  CommitsReadyState(this.commits);
}

class CommitsErrorState extends CommitsState {
  final String message;

  CommitsErrorState(this.message);
}

/// events

abstract class CommitsEvent {}

class CommitsGetEvent extends CommitsEvent {
  final String login;
  final String repo;

  CommitsGetEvent(this.login, this.repo);
}
