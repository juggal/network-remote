class BaseUrl {
  static String baseUrl;

  BaseUrl(String url) {
    baseUrl = url;
  }

  static Uri getUri(String route) {
    return Uri.http(baseUrl, route);
  }
}
