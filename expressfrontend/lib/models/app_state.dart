import 'package:expressfrontend/models/setting/setting.dart';
import 'package:meta/meta.dart';
import 'weather/weather_state.dart';

@immutable
class AppState {
  final WeatherState weather;
  final Setting setting;
  AppState({this.weather, this.setting});

  factory AppState.initial() =>
      AppState(weather: WeatherState.initial(), setting: Setting.initial());

  AppState copyWith({
    AppState weather,
  }) {
    return AppState(weather: weather ?? this.weather);
  }
}
