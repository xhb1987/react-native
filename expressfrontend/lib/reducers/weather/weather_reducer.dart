import 'dart:convert';

import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/weather/city.dart';
import 'package:expressfrontend/models/weather/weather_state.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

WeatherState weatherReducer(WeatherState weatherState, FSA action) {
  WeatherState newWeatherState = weatherState;
  print(action.type);
  switch (action.type) {
    case CITY_QUARY_REQUST:
      newWeatherState.city.error = false;
      newWeatherState.city.data = null;
      newWeatherState.city.loading = true;
      return newWeatherState;
    case CITY_QUARY_SUCCESS:
      print(json.decode(action.payload));
      newWeatherState.city.error = false;
      newWeatherState.city.loading = false;
      newWeatherState.city.data = cityFromJson(action.payload);
      return newWeatherState;
    case CITY_QUARY_FAIL:
      newWeatherState.city.error = true;
      newWeatherState.city.data = null;
      newWeatherState.city.loading = false;
      return newWeatherState;
    default:
      return newWeatherState;
  }
}

class ResponseMessage {
  int statusCode;
  String message;
  String data;

  ResponseMessage({this.statusCode, this.message, this.data});

  factory ResponseMessage.fromJSON(Map<String, dynamic> json) =>
      ResponseMessage(
          statusCode: json['statusCode'] as int,
          message: json['message'] as String,
          data: json['data'] as String);
}

List<City> cityFromJson(dynamic payload) {
  ResponseMessage responseMessage =
      ResponseMessage.fromJSON(json.decode(payload));

  final parsed =
      List<Map<String, dynamic>>.from(json.decode(responseMessage.data));
  List<City> cities = parsed.map((p) => City.fromJSON(p)).toList();

  return cities;
}
