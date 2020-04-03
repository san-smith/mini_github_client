import 'package:mini_github_client/data/api/api_config.dart';
import 'package:mini_github_client/data/api/api_util.dart';
import 'package:mini_github_client/data/api/service/rest_service.dart';

class ApiModule {
  static ApiUtil _apiUtil;

  static RestService _restService() {
    return RestService(ApiConfig.REST_URL);
  }

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(
        _restService(),
      );
    }
    return _apiUtil;
  }
}
