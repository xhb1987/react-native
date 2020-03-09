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

  CityState({this.error, this.loading, this.data});

  factory CityState.initial() =>
      CityState(error: null, loading: true, data: []);
}

class WeatherDetailState {
  dynamic error;
  bool loading;
  Weather weather;

  WeatherDetailState({this.error, this.loading, this.weather});
  factory WeatherDetailState.initial() =>
      WeatherDetailState(error: null, loading: true, weather: null);
}
