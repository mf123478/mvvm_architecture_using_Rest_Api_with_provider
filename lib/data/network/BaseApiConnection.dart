abstract class BaseApiConnection{

  Future<dynamic> getGetApiRequest(url);

  Future<dynamic> getPostApiRequest(url, dynamic data);


}