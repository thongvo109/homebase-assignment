import 'package:dio/dio.dart';
import 'package:weatherapp/api/api_error.dart';
import 'package:weatherapp/collection/location_collection.dart';
import 'package:weatherapp/model/index.dart';

class WeatherApi with ApiErrorHandler {
  final Dio _dio;
  WeatherApi(this._dio);

  Future<LocationCollection> getLocation(String query) async {
    try {
      final Response response =
          await _dio.get("/search.json", queryParameters: {
        "q": query,
      });
      return LocationCollection.fromJson(response.data);
    } catch (e) {
      return LocationCollection.withError(handleError(e));
    }
  }

  Future<WeatherCurrentModel> getCurrentWeather(String query) async {
    try {
      final Response response =
          await _dio.get('/current.json', queryParameters: {
        "q": query,
      });
      return WeatherCurrentModel.fromJson(response.data);
    } catch (e) {
      return WeatherCurrentModel.withError(handleError(e));
    }
  }
}
