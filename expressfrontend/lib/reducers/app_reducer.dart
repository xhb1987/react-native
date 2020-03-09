import 'package:expressfrontend/models/app_state.dart';
import 'package:expressfrontend/reducers/weather/weather_reducer.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    weather: weatherReducer(state.weather, action),
  );
}
