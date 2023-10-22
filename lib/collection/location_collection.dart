import 'package:weatherapp/api/api_error.dart';
import 'package:weatherapp/collection/base_collection.dart';
import 'package:weatherapp/model/location_model.dart';

class LocationCollection extends BaseCollection<LocationModel> {
  LocationCollection() : super();
  LocationCollection.fromJson(dynamic json)
      : super(
          items: (json as List).map((e) => LocationModel.fromJson(e)).toList(),
        );

  LocationCollection.withError(ApiError apiError) : super(error: apiError);
}
