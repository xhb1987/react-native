import 'package:expressfrontend/models/weather/weather.dart';

import 'city.dart';

class WeatherState {
  CityState city;
  WeatherDetailState weatherDetail;
  WeatherState({this.city, this.weatherDetail});

  factory WeatherState.initial() => WeatherState(
      city: CityState.initial(), weatherDetail: WeatherDetailState.initial());
}

class CityState {
  dynamic error;
  bool loading;
  List<City> data;
  String searchCity;

  CityState({this.error, this.loading, this.data, this.searchCity});

  factory CityState.initial() =>
      CityState(error: null, loading: true, data: [], searchCity: "");
}

class WeatherDetailState {
  dynamic error;
  bool loading;
  Weather weather;

  WeatherDetailState({this.error, this.loading, this.weather});
  factory WeatherDetailState.initial() => WeatherDetailState(
      error: null,
      loading: true,
      weather: Weather(consolidatedWeather: [], title: "", time: ""));
}
