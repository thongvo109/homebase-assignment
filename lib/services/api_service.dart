import 'package:dio/dio.dart';
import 'package:weatherapp/api/weather_api.dart';
import 'package:weatherapp/services/logger.dart';

class ApiService {
  static const Duration _receiveTimeout = Duration(milliseconds: 1000);
  static const Duration _connectTimeout = Duration(milliseconds: 1000);
  static const Duration _sendTimeout = Duration(milliseconds: 1000);

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://api.weatherapi.com/v1",
      receiveTimeout: _receiveTimeout,
      connectTimeout: _connectTimeout,
      sendTimeout: _sendTimeout,
    ),
  );

  static final ApiService _instance = ApiService._();

  static ApiService get i => _instance;
  late final WeatherApi weather;
  ApiService._() {
    _init();
  }

  void _init() {
    final List<Interceptor> interceptors = [
      LoggerInterceptor(),
      CustomInterceptor(),
    ];
    _dio.interceptors.addAll(interceptors);
    weather = WeatherApi(_dio);
  }
}

class CustomInterceptor extends Interceptor {
  static const _apiKey = String.fromEnvironment("API_KEY");
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['key'] = _apiKey;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
