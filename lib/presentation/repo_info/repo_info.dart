import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_github_client/domain/bloc/commits_bloc.dart';
import 'package:mini_github_client/domain/model/commit.dart';
import 'package:mini_github_client/internal/dependencies/user_module.dart';

class RepoInfo extends StatefulWidget {
  final String login;
  final String repo;

  const RepoInfo(
    this.login,
    this.repo, {
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RepoInfoState();
}

class _RepoInfoState extends State<RepoInfo> {
  CommitsBloc _commitsBloc = UserModule.commitsBloc();

  @override
  void initState() {
    super.initState();
    _commitsBloc.add(CommitsGetEvent(widget.login, widget.repo));
  }

  @override
  void dispose() {
    _commitsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repo Info'),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return BlocBuilder<CommitsBloc, CommitsState>(
      bloc: _commitsBloc,
      builder: (context, state) {
        if (state is CommitsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CommitsReadyState) {
          return _getRepos(state.commits);
        }
        if (state is CommitsErrorState) {
          return Center(
            child: Text('Не удалось получить репозитории'),
          );
        }
        return Container();
      },
    );
  }

  Widget _getRepos(List<Commit> repos) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      itemCount: repos.length,
      itemBuilder: (context, index) => _getItem(repos[index]),
    );
  }

  Widget _getItem(Commit commit) {
    return Card(
      child: Row(
        children: <Widget>[
          _getUserInfo(commit),
          Expanded(
            child: _getCommitInfo(commit),
          ),
        ],
      ),
    );
  }

  Widget _getUserInfo(Commit commit) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          if (commit.author.avatarUrl.isNotEmpty)
            CircleAvatar(
              backgroundImage: NetworkImage(commit.author.avatarUrl),
            ),
          SizedBox(height: 5),
          Text(
            commit.author.login,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCommitInfo(Commit commit) {
    return Column(
      children: <Widget>[
        Text(
          commit.sha,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          commit.message,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
