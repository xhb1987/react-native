import 'package:expressfrontend/state/search_state.dart';
import 'package:expressfrontend/state/setting_state.dart';
import 'package:expressfrontend/state/weather_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final WeatherState weather;
  final SettingState setting;
  final SearchState search;

  AppState({this.weather, this.setting, this.search});

  factory AppState.initial() => AppState(
      weather: WeatherState.initial(),
      setting: SettingState.initial(),
      search: SearchState.initial());

  AppState copyWith({
    AppState weather,
  }) {
    return AppState(weather: weather ?? this.weather);
  }
}
