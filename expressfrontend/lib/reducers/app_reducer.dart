import 'package:expressfrontend/reducers/search/search_reducer.dart';
import 'package:expressfrontend/reducers/setting/setting_reducer.dart';
import 'package:expressfrontend/reducers/weather/weather_reducer.dart';
import 'package:expressfrontend/state/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
      weather: weatherReducer(state.weather, action),
      setting: settingReducer(state.setting, action),
      search: searchReducer(state.search, action));
}
