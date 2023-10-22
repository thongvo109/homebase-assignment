import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:weatherapp/utils/pretty_json_string.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(prettyJsonStr({
      "from": "onRequest",
      "Time": DateTime.now().toString(),
      "baseUrl": options.baseUrl,
      "path": options.path,
      "headers": options.headers,
      "method": options.method,
      "requestData": options.data,
      "queryParameters": options.queryParameters,
    }));
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(prettyJsonStr({
      "from": "onResponse",
      "Time": DateTime.now().toString(),
      "statusCode": response.statusCode,
      "baseUrl": response.requestOptions.baseUrl,
      "path": response.requestOptions.path,
      "method": response.requestOptions.method,
      "responseData": response.data,
    }));
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(prettyJsonStr({
      "from": "onError",
      "Time": DateTime.now().toString(),
      "baseUrl": err.requestOptions.baseUrl,
      "path": err.requestOptions.path,
      "type_dio": err.type,
      "errorCode": err.response?.data["error"]["code"] ?? "",
      "message": err.response?.data["error"]["message"],
      "statusCode": err.response?.statusCode,
      "error": err.error,
      "requestData": err.requestOptions.data,
      "responseData": err.response?.data,
    }));
    super.onError(err, handler);
  }
}
