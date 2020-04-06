import 'package:expressfrontend/models/weather/weather.dart';

class WeatherState {
  dynamic error;
  bool loading;
  Weather weather;

  WeatherState({this.error, this.loading, this.weather});
  factory WeatherState.initial() => WeatherState(
      error: null,
      loading: false,
      weather: Weather(consolidatedWeather: [], title: "", time: ""));
}
