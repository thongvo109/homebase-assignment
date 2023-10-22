import 'package:hive/hive.dart';
import 'package:weatherapp/api/api_error.dart';

class BaseModel extends HiveObject {
  ApiError? error;

  BaseModel({this.error});

  BaseModel.withError(ApiError? e) : error = e;
}
