import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_github_client/domain/bloc/repos_bloc.dart';
import 'package:mini_github_client/domain/model/repository.dart';
import 'package:mini_github_client/domain/model/user.dart';
import 'package:mini_github_client/internal/dependencies/user_module.dart';
import 'package:mini_github_client/presentation/repo_info/repo_info.dart';

class Repositories extends StatefulWidget {
  final User user;

  const Repositories(
    this.user, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RepositoriesState();
}

class _RepositoriesState extends State<Repositories> {
  ReposBloc _reposBloc = UserModule.reposBloc();

  @override
  void initState() {
    super.initState();
    _reposBloc.add(ReposGetEvent(widget.user.login));
  }

  @override
  void dispose() {
    _reposBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repos'),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return BlocBuilder<ReposBloc, ReposState>(
      bloc: _reposBloc,
      builder: (context, state) {
        if (state is ReposLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ReposReadyState) {
          return _getRepos(state.repos);
        }
        if (state is ReposErrorState) {
          return Center(
            child: Text('Не удалось получить репозитории'),
          );
        }
        return Container();
      },
    );
  }

  Widget _getRepos(List<Repository> repos) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      itemCount: repos.length,
      itemBuilder: (context, index) => _getItem(repos[index]),
    );
  }

  Widget _getItem(Repository repo) {
    return Card(
      child: InkWell(
        onTap: () => _goToRepoDetails(repo.name),
        child: Row(
          children: <Widget>[
            _getUserInfo(),
            Expanded(
              child: _getRepoInfo(repo),
            ),
            _getRepoStars(repo.stargazersCount),
          ],
        ),
      ),
    );
  }

  Widget _getUserInfo() {
    return Container(
      width: 80,
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          if (widget.user.avatarUrl.isNotEmpty)
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.avatarUrl),
            ),
          SizedBox(height: 5),
          Text(
            widget.user.login,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRepoStars(int count) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Icon(Icons.star),
          Text('$count'),
        ],
      ),
    );
  }

  Widget _getRepoInfo(Repository repo) {
    return Column(
      children: <Widget>[
        Text(
          repo.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          repo.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _goToRepoDetails(String repo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RepoInfo(widget.user.login, repo),
      ),
    );
  }
}
