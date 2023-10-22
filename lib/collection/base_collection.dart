import 'package:weatherapp/api/api_error.dart';

class BaseCollection<T> {
  final List<T> items;
  final ApiError? error;

  BaseCollection({this.items = const [], this.error});

  BaseCollection.withError(ApiError apiError)
      : items = [],
        error = apiError;
}
