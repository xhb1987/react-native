import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

const CITY_WEATHER_QUARY_REQUST = "CITY_WEATHER_QUARY_REQUST";
const CITY_WEATHER_QUARY_SUCCESS = "CITY_WEATHER_QUARY_SUCCESS";
const CITY_WEATHER_QUARY_FAIL = "CITY_WEATHER_QUARY_FAIL";
const ADD_CITY_WEATHER_DETAIL = 'ADD_CITY_EATHER_DETAIL';
const UPDATE_WEATHER_INDEX = 'UPDATE_WEATHER_INDEX';

FSA updateWeatherIndex(int index) {
  return FSA(type: UPDATE_WEATHER_INDEX, payload: index);
}

FSA addCityWeatherDetail(Weather weather) {
  return FSA(type: ADD_CITY_WEATHER_DETAIL, payload: weather);
}

RSAA getCityWeatherRequest(int woeid) {
  return RSAA(
      method: 'GET',
      endpoint:
          "https://yn4kddojti.execute-api.us-east-2.amazonaws.com/dev/weather/weather/$woeid",
      types: [
        CITY_WEATHER_QUARY_REQUST,
        CITY_WEATHER_QUARY_SUCCESS,
        CITY_WEATHER_QUARY_FAIL
      ],
      headers: {
        'Content-Type': 'application/json',
      });
}

ThunkAction<AppState> getCityWeather(int woeid) =>
    (Store<AppState> store) => store.dispatch(getCityWeatherRequest(woeid));
