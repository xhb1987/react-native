import 'dart:convert';

import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/weather/city.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/models/weather/weather_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

WeatherState weatherReducer(WeatherState weatherState, FSA action) {
  WeatherState newWeatherState = weatherState;
  switch (action.type) {
    case CITY_QUARY_REQUST:
      newWeatherState.city.error = false;
      newWeatherState.city.data = [];
      newWeatherState.city.loading = true;
      return newWeatherState;
    case CITY_QUARY_SUCCESS:
      newWeatherState.city.error = false;
      newWeatherState.city.loading = false;
      newWeatherState.city.data = cityFromJson(action.payload);
      return newWeatherState;
    case CITY_QUARY_FAIL:
      newWeatherState.city.error = true;
      newWeatherState.city.data = [];
      newWeatherState.city.loading = false;
      return newWeatherState;
    case CITY_WEATHER_QUARY_REQUST:
      newWeatherState.weatherDetail.loading = true;
      newWeatherState.weatherDetail.error = false;
      newWeatherState.weatherDetail.weather = null;
      return newWeatherState;
    case CITY_WEATHER_QUARY_SUCCESS:
      newWeatherState.weatherDetail.loading = false;
      newWeatherState.weatherDetail.error = false;
      newWeatherState.weatherDetail.weather = weatherFromJson(action.payload);
      return newWeatherState;
    case CITY_WEATHER_QUARY_FAIL:
      newWeatherState.weatherDetail.loading = false;
      newWeatherState.weatherDetail.error = true;
      newWeatherState.weatherDetail.weather = null;
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

Weather weatherFromJson(dynamic payload) {
  ResponseMessage responseMessage =
      ResponseMessage.fromJSON(json.decode(payload));
  Weather weather = Weather.fromJson(json.decode(responseMessage.data));

  return weather;
}

List<City> cityFromJson(dynamic payload) {
  ResponseMessage responseMessage =
      ResponseMessage.fromJSON(json.decode(payload));

  final parsed =
      List<Map<String, dynamic>>.from(json.decode(responseMessage.data));
  List<City> cities = parsed.map((p) => City.fromJSON(p)).toList();

  return cities;
}
