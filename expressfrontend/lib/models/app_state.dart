import 'package:meta/meta.dart';
import 'weather/weather_state.dart';

@immutable
class AppState {
  final WeatherState weather;

  AppState({this.weather});

  factory AppState.initial() => AppState(weather: WeatherState.initial());

  AppState copyWith({
    AppState weather,
  }) {
    return AppState(weather: weather ?? this.weather);
  }
}
