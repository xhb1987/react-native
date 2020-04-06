import 'dart:convert';

import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/models/response-message/response_message.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/state/weather_state.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

WeatherState weatherReducer(WeatherState weatherState, FSA action) {
  WeatherState newWeatherState = weatherState;
  switch (action.type) {
    case CITY_WEATHER_QUARY_REQUST:
      newWeatherState.loading = true;
      newWeatherState.error = false;
      newWeatherState.weather = null;
      return newWeatherState;
    case CITY_WEATHER_QUARY_SUCCESS:
      newWeatherState.loading = false;
      newWeatherState.error = false;
      newWeatherState.weather = weatherFromJson(action.payload);
      return newWeatherState;
    case CITY_WEATHER_QUARY_FAIL:
      newWeatherState.loading = false;
      newWeatherState.error = true;
      newWeatherState.weather = null;
      return newWeatherState;
    default:
      return newWeatherState;
  }
}

Weather weatherFromJson(dynamic payload) {
  ResponseMessage responseMessage =
      ResponseMessage.fromJSON(json.decode(payload));
  Weather weather = Weather.fromJson(json.decode(responseMessage.data));

  return weather;
}
