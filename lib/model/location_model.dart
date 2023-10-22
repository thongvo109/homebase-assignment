import 'package:hive/hive.dart';
import 'package:weatherapp/api/api_error.dart';
import 'package:weatherapp/model/base_model.dart';

part 'location_model.g.dart';

@HiveType(typeId: 0)
class LocationModel extends BaseModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? region;
  @HiveField(3)
  String? country;
  @HiveField(4)
  double? lat;
  @HiveField(5)
  double? lon;
  @HiveField(6)
  String? url;

  LocationModel({
    this.id,
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.url,
  });

  LocationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        region = json['region'],
        country = json['country'],
        lat = json['lat'].toDouble(),
        lon = json['lon'].toDouble(),
        url = json['url'];

  LocationModel.withError(ApiError apiError) : super(error: apiError);
}


// {
//     "id": 2796590,
//     "name": "Holborn",
//     "region": "Camden Greater London",
//     "country": "United Kingdom",
//     "lat": 51.52,
//     "lon": -0.12,
//     "url": "holborn-camden-greater-london-united-kingdom"
//   }