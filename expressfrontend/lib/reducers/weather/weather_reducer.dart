import 'dart:convert';

import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/models/response-message/response_message.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/state/weather_state.dart';
import 'package:expressfrontend/util/storage.dart';
import 'package:expressfrontend/util/weather_helper.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

WeatherState weatherReducer(WeatherState weatherState, FSA action) {
  WeatherState newWeatherState = weatherState;
  print(action.type);
  switch (action.type) {
    case CITY_WEATHER_QUARY_REQUST:
      newWeatherState.loading = true;
      newWeatherState.error = false;
      return newWeatherState;
    case CITY_WEATHER_QUARY_SUCCESS:
      newWeatherState.loading = false;
      newWeatherState.error = false;

      Weather weather = weatherFromJson(action.payload);
      if (newWeatherState.weather
          .any((Weather val) => val.title == weather.title)) {
        newWeatherState.weather
            .removeWhere((Weather value) => value.title == weather.title);
      }
      newWeatherState.weather.add(weatherFromJson(action.payload));
      print(newWeatherState.weather.length);
      return newWeatherState;
    case CITY_WEATHER_QUARY_FAIL:
      newWeatherState.loading = false;
      newWeatherState.error = true;
      newWeatherState.weather = [];
      return newWeatherState;
    case ADD_CITY_WEATHER_DETAIL:
      newWeatherState.weather.add(action.payload);
      return newWeatherState;
    case UPDATE_WEATHER_INDEX:
      newWeatherState.index = action.payload;
      return newWeatherState;
    case DELETE_CITY:
      List<Weather> weathers = newWeatherState.weather;
      String cityName = action.payload;

      weathers.removeWhere((Weather weather) => weather.title == cityName);
      Storage.deleteItem(cityName.replaceAll(" ", ""));
      newWeatherState.weather = weathers;
      return newWeatherState;

    default:
      return newWeatherState;
  }
}
