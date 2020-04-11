import 'package:expressfrontend/models/weather/weather.dart';

class WeatherState {
  dynamic error;
  bool loading;
  List<Weather> weather;
  int index;

  WeatherState({this.error, this.loading, this.weather, this.index});
  factory WeatherState.initial() =>
      WeatherState(error: null, loading: false, weather: [], index: 0);
}
