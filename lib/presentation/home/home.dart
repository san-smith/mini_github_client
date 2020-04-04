import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_github_client/domain/bloc/user_bloc.dart';
import 'package:mini_github_client/domain/model/user.dart';
import 'package:mini_github_client/internal/dependencies/user_module.dart';
import 'package:mini_github_client/presentation/repositories/repositories.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  UserBloc _userBloc = UserModule.userBloc();

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mini Github Client'),
        ),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getSearch(),
          SizedBox(height: 15),
          Expanded(child: _getContent()),
        ],
      ),
    );
  }

  Widget _getSearch() {
    return TextField(
      controller: _controller,
      autocorrect: false,
      autofocus: false,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'type user name',
        suffix: IconButton(
          icon: Icon(Icons.search),
          onPressed: _findUser,
        ),
      ),
    );
  }

  Widget _getContent() {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is UserReadyState) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20),
            child: _getUserInfo(state.user),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text('Не удалось найти пользователя ${_controller.text}'),
          );
        }
        return Container();
      },
    );
  }

  Widget _getUserInfo(User user) {
    return Column(
      children: <Widget>[
        if (user.avatarUrl.isNotEmpty)
          Image.network(
            user.avatarUrl,
          ),
        SizedBox(height: 15),
        Text(
          user.login,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (user.name.isNotEmpty) ...[
          SizedBox(height: 15),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ],
        if (user.location.isNotEmpty) ...[
          SizedBox(height: 15),
          Text(
            user.location,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
        if (user.bio.isNotEmpty) ...[
          SizedBox(height: 15),
          Text(
            user.bio,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
        SizedBox(height: 15),
        RaisedButton(
          child: Text('Репозитории (${user.publicRepos})'),
          onPressed: () => _goToRepos(user),
        ),
      ],
    );
  }

  void _findUser() {
    if (_controller.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      _userBloc.add(UserGetEvent(_controller.text));
    }
  }

  void _goToRepos(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Repositories(user),
      ),
    );
  }
}
