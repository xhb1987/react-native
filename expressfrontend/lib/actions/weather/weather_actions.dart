import 'package:expressfrontend/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

const CITY_WEATHER_QUARY_REQUST = "CITY_WEATHER_QUARY_REQUST";
const CITY_WEATHER_QUARY_SUCCESS = "CITY_WEATHER_QUARY_SUCCESS";
const CITY_WEATHER_QUARY_FAIL = "CITY_WEATHER_QUARY_FAIL";

RSAA getCityWeatherRequest(int woeid) {
  return RSAA(
      method: 'GET',
      endpoint: "http://localhost:3001/weather/weather/$woeid",
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
