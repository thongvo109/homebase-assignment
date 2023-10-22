// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';

mixin ApiErrorHandler {
  ApiError handleError(dynamic error) {
    int errCode = 0;
    String msg = 'Something went wrong';
    int statusCode = 0;

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          msg =
              "Connection timed out. Please check your internet connection and try again.";
        case DioExceptionType.sendTimeout:
          msg = "Sending data timed out. Please try again later.";
        case DioExceptionType.receiveTimeout:
          msg =
              "Cannot receive data: Connection timed out. Please try again later.";
        case DioExceptionType.badResponse:
          errCode = error.response?.data["error"]['code'] ?? 0;
          msg = customErrorMsg(
              errCode,
              error.response?.data["error"]['message'] ??
                  'Something went wrong');
          statusCode = error.response?.statusCode ?? 0;
        case DioExceptionType.cancel:
          msg = "Operation cancelled. Please try again if needed.";
        case DioExceptionType.unknown:
          msg = "Unknown";
        case DioExceptionType.badCertificate:
          msg =
              "Invalid SSL certificate. Please check the certificate and try again.";
        case DioExceptionType.connectionError:
          msg =
              "Connection error. Please check your internet connection and try again.";
        default:
          msg = "Something went wrong";
      }
    } else if (error is NoSuchMethodError) {
      msg = "Error: NoSuchMethodError";
    } else if (error is TypeError) {
      msg = "Error: TypeError";
    } else if (error is FormatException) {
      msg = error.message;
    } else {
      msg = "Something went wrong";
    }
    return ApiError(errCode, msg, statusCode);
  }

  String customErrorMsg(int code, String msg) {
    switch (code) {
      case 1003:
        return "City name and Zipcode cannot be left blank";
      default:
        return msg;
    }
  }
}

class ApiError {
  final int errCode;
  final String msg;
  final int statusCode;

  ApiError(
    this.errCode,
    this.msg,
    this.statusCode,
  );
}
