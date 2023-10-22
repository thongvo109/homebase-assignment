import 'package:weatherapp/api/api_error.dart';
import 'package:weatherapp/model/base_model.dart';
import 'package:weatherapp/model/index.dart';

class WeatherCurrentModel extends BaseModel {
  CurrentModel? currentModel;
  LocationModel? locationModel;

  WeatherCurrentModel(this.currentModel, this.locationModel);

  WeatherCurrentModel.fromJson(Map<String, dynamic> json)
      : currentModel = CurrentModel.fromJson(json['current']),
        locationModel = LocationModel.fromJson(json['location']);

  WeatherCurrentModel.withError(ApiError apiError) : super(error: apiError);
}

class CurrentModel {
  final int? lastUpdatedEpoch;
  final String? lastUpdated;
  final num? tempC;
  final num? tempF;
  final int? isDay;
  final Condition? condition;
  final num? windMph;
  final num? windKph;
  final num? windDegree;
  final String? windDir;
  final num? pressureMb;
  final num? pressureIn;
  final num? precipMm;
  final num? precipIn;
  final num? humidity;
  final num? cloud;
  final num? feelslikeC;
  final num? feelslikeF;
  final num? visKm;
  final num? visMiles;
  final num? uv;
  final num? gustMph;
  final num? gustKph;
  final Map<String, num>? airQuality;

  CurrentModel({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
    this.airQuality,
  });

  CurrentModel.fromJson(Map<String, dynamic> json)
      : lastUpdatedEpoch = json["last_updated_epoch"],
        lastUpdated = json["last_updated"],
        tempC = json["temp_c"],
        tempF = json["temp_f"],
        isDay = json["is_day"],
        condition = Condition.fromJson(json["condition"]),
        windMph = json["wind_mph"],
        windKph = json["wind_kph"],
        windDegree = json["wind_degree"],
        windDir = json["wind_dir"],
        pressureMb = json["pressure_mb"],
        pressureIn = json["pressure_in"],
        precipMm = json["precip_mm"],
        precipIn = json["precip_in"],
        humidity = json["humidity"],
        cloud = json["cloud"],
        feelslikeC = json["feelslike_c"],
        feelslikeF = json["feelslike_f"],
        visKm = json["vis_km"],
        visMiles = json["vis_miles"],
        uv = json["uv"],
        gustMph = json["gust_mph"],
        gustKph = json["gust_kph"],
        airQuality = json["air_quality"] != null
            ? Map.from(json["air_quality"])
                .map((k, v) => MapEntry<String, double>(k, v))
            : null;
}
