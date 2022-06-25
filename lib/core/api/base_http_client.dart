import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../error/exceptions.dart';

abstract class BaseHttpClient {
  late http.Client _instance;
  Map<String, String>? headers;
  late String _apiBaseUrl;

  initHttp() async {
    _instance = http.Client();
    headers = await _headers();
    const _baseUrl = "https://rickandmortyapi.com";
    _apiBaseUrl = _baseUrl.split('https://')[1];
  }

  Future<Map<String, String>> _headers() async {
    return {
      "Content-Type": "application/json",
    };
  }

  Future<Response> get(String url, {Map<String, String>? queryParams}) async {
    await initHttp();

    final uri = _getUri(url, queryParams);
    final response = await _instance.get(
      uri,
      headers: headers,
    );
    return _processResponse(response);
  }

  Uri _getUri(
    String urlPath,
    Map<String, String>? queryParams,
  ) {
    final authority = _apiBaseUrl.replaceAll(RegExp(r'https://|http://'), '');
    final uri = Uri.https(authority, urlPath, queryParams);

    return uri;
  }

  _processResponse(Response response) {
    var statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode <= 300 ||
        statusCode >= 404 && statusCode <= 405) {
      return response;
    } else if (statusCode == 400) {
      throw BadRequestException(response.body.toString());
    } else if (statusCode == 401 || statusCode == 403) {
      throw UnauthorisedException(response.body.toString());
    }
  }
}
