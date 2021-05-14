class BaseUrl {
  static String host;
  static String port;
  static String baseUrl;

  BaseUrl(String host, String port) {
    BaseUrl.host = host;
    BaseUrl.port = port;
    BaseUrl.baseUrl = "${BaseUrl.host}:${BaseUrl.port}";
  }

  static Uri getUri(String route) {
    return Uri.http(BaseUrl.baseUrl, route);
  }

  static Uri getSocketUri(String port) {
    return Uri.parse("ws://${BaseUrl.host}:$port");
  }
}
