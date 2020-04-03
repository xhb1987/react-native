import 'package:expressfrontend/models/app_state.dart';
import 'package:expressfrontend/reducers/setting/setting_reducer.dart';
import 'package:expressfrontend/reducers/weather/weather_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
      weather: weatherReducer(state.weather, action),
      setting: settingReducer(state.setting, action));
}
