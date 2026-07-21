abstract class BaseApiServices {
  Future<dynamic> getGetApi(String url);
  Future<dynamic>updateApi(String url,dynamic data);
  Future<dynamic> getPostApi(String url, dynamic data);
}
