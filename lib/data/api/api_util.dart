import 'package:mini_github_client/data/api/mapper/user_mapper.dart';
import 'package:mini_github_client/data/api/service/rest_service.dart';
import 'package:mini_github_client/domain/model/user.dart';

class ApiUtil {
  final RestService _restService;

  ApiUtil(this._restService);

  Future<User> getUser(String login) async {
    var user = await _restService.getUser(login);
    return UserMapper.fromApi(user);
  }
}