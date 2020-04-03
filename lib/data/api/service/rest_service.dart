import 'package:dio/dio.dart';

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
      throw Exception(error.response?.data);
    }
  }
}
