import 'dart:convert';
import 'dart:async';

import 'package:educational_app/services/api_client/app_exceptions.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:http/http.dart' as http;

class BaseClientModel {
  // ignore: constant_identifier_names
  static const int TIME_OUT_DURATION = 20;
  Future<dynamic> getWithoutId(
      String host, String api, Map<String, String> headers) async {
    final uri = Uri.http(host, api);
    try {
      var response = await StaticValues.client
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> getWithId(
    String host,
    String api,
    Map<String, dynamic> id,
    Map<String, String> headers,
  ) async {
    final uri = Uri.http(host, api, id);
    try {
      var response = await StaticValues.client
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> post(
    String host,
    String api,
    Map<String, String> headers,
    dynamic data,
  ) async {
    var uri = Uri.http(host, api);
    var jsonData = json.encode(data);
    try {
      var response = await http
          .post(
            uri,
            body: jsonData,
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
