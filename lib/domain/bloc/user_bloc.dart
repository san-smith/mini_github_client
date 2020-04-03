import 'package:bloc/bloc.dart';
import 'package:mini_github_client/data/repository/user_data_repository.dart';
import 'package:mini_github_client/domain/model/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDataRepository _userDataRepository;

  UserBloc(this._userDataRepository);

  @override
  UserState get initialState => null;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserGetEvent) {
      yield* _getUserToState(event.login);
    }
  }

  Stream<UserState> _getUserToState(String login) async* {
    yield UserLoadingState();
    try {
      var user = await _userDataRepository.getUser(login);
      yield UserReadyState(user);
    } catch (e) {
      yield UserErrorState(e.toString());
    }
  }
}

/// states

abstract class UserState {
}

class UserLoadingState extends UserState {}

class UserReadyState extends UserState {
  final User user;

  UserReadyState(this.user);
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);
}

/// events

abstract class UserEvent {
}

class UserGetEvent extends UserEvent {
  final String login;

  UserGetEvent(this.login);
}