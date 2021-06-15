import 'dart:async';
import 'dart:convert';

import 'package:consulta_estados_cidades/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_exception.dart';

class ApiBaseHelper {
  Future<dynamic> post({
    @required String url,
    @required String body,
  }) async {
    return await _request(
      httpMethod: "POST",
      url: url,
      body: body,
    );
  }

  Future<dynamic> put({
    @required String url,
    @required String body,
    @required String pathVariable,
  }) async {
    return await _request(
      httpMethod: "PUT",
      url: url,
      pathVariable: pathVariable,
      body: body,
    );
  }

  Future<dynamic> delete({
    @required String url,
    @required String pathVariable,
  }) async {
    return await _request(
      httpMethod: "DELETE",
      url: url,
      pathVariable: pathVariable,
    );
  }

  Future<dynamic> get({
    @required String url,
    String queryParams,
    String pathVariable,
  }) async {
    return await _request(
      httpMethod: "GET",
      url: url,
      queryParams: queryParams,
      pathVariable: pathVariable,
    );
  }

  Future<dynamic> _request({
    @required String httpMethod,
    @required String url,
    String body,
    String queryParams,
    String pathVariable,
  }) async {
    dynamic responseJson;

    try {
      var headers;

      headers = {'Content-Type': 'application/json'};

      queryParams = queryParams == null ? "" : "?$queryParams";
      pathVariable = pathVariable == null ? "" : "/$pathVariable";

      if (!kReleaseMode) {
        print("$base_url$url$queryParams$pathVariable");
      }

      var request = http.Request(
          httpMethod, Uri.parse("$base_url$url$queryParams$pathVariable"));

      if (body != null) {
        request.body = body;
      }

      request.headers.addAll(headers);

      http.Response response =
          await http.Response.fromStream(await request.send());

      var responseHeaders = response.headers;

      responseJson = _returnResponse(response, responseHeaders);

      return responseJson;
    } catch (e) {
      throw Exception(e);
    }
  }

  dynamic _returnResponse(http.Response response, var responseHeaders) {
    if (!kReleaseMode) {
      print("${response.statusCode} ${utf8.decode(response.bodyBytes)}");
    }

    switch (response.statusCode) {
      case 201:
      case 200:
        if (response.bodyBytes.length == 0) {
          return null;
        } else {
          final Map<String, dynamic> dataResponseHeaders = new Map<String, dynamic>();
          dataResponseHeaders['totalElements'] = responseHeaders["totalelements"];
          dataResponseHeaders['totalPages']    = responseHeaders["totalpages"];

          final Map<String, dynamic> data = new Map<String, dynamic>();
          data['headers'] = json.decode(json.encode(dataResponseHeaders));
          data['body']    = json.decode(utf8.decode(response.bodyBytes));

          //return json.decode(utf8.decode(response.bodyBytes));
          return data;
        }

        break;
      case 400:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw BadRequestException(
          response.statusCode,
          error["menssagem"],
        );

      case 401:
      case 403:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw UnauthorisedException(
          response.statusCode,
          error["menssagem"],
        );

      case 500:
      default:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw FetchDataException(
          response.statusCode,
          error["menssagem"],
        );
    }
  }
}
