import 'package:expressfrontend/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

const CITY_QUARY_REQUST = "CITY_QUARY_REQUST";
const CITY_QUARY_SUCCESS = "CITY_QUARY_SUCCESS";
const CITY_QUARY_FAIL = "CITY_QUARY_FAIL";

const CITY_WEATHER_QUARY_REQUST = "CITY_WEATHER_QUARY_REQUST";
const CITY_WEATHER_QUARY_SUCCESS = "CITY_WEATHER_QUARY_SUCCESS";
const CITY_WEATHER_QUARY_FAIL = "CITY_WEATHER_QUARY_FAIL";

RSAA getCityRequest(String city) {
  return RSAA(
      method: 'GET',
      endpoint: "http://localhost:3000/weather/location/$city",
      types: [
        CITY_QUARY_REQUST,
        CITY_QUARY_SUCCESS,
        CITY_QUARY_FAIL
      ],
      headers: {
        'Content-Type': 'application/json',
      });
}

ThunkAction<AppState> getCity({String city = "Guangzhou"}) =>
    (Store<AppState> store) => store.dispatch(getCityRequest(city));

RSAA getCityWeatherRequest(int woeid) {
  return RSAA(
      method: 'GET',
      endpoint: "http://localhost:3000/weather/weather/$woeid",
      types: [
        CITY_QUARY_REQUST,
        CITY_QUARY_SUCCESS,
        CITY_QUARY_FAIL
      ],
      headers: {
        'Content-Type': 'application/json',
      });
}

ThunkAction<AppState> getCityWeather({int city = 2161838}) =>
    (Store<AppState> store) => store.dispatch(getCityWeatherRequest(city));
