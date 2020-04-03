import 'package:dio/dio.dart';
import 'package:mini_github_client/data/api/model/api_user.dart';

class Route {
  static String _getUser(String name) => '/users/$name';
}

class RestService {
  final String _baseUrl;
  Dio _dio;

  RestService(this._baseUrl);

  Dio _getDio() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(baseUrl: _baseUrl),
      );
    }
    return _dio;
  }

  Future<Response<T>> _get<T>(String path) async {
    final dio = _getDio();
    return _performRequest<T>(
      dio.get(path),
    );
  }

  Future<Response<T>> _performRequest<T>(Future<Response<T>> request) async {
    try {
      final result = await request;
      return result;
    } on DioError catch (error) {
      throw Exception(error.response?.data['message']);
    }
  }

  Future<ApiUser> getUser(String login) async {
    final response = await _get(
      Route._getUser(login),
    );
    return ApiUser.fromMap(response.data);
  }
}
