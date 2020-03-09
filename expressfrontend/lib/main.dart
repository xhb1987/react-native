import 'package:expressfrontend/models/app_state.dart';
import 'package:expressfrontend/reducers/app_reducer.dart';
import 'package:expressfrontend/routes/routes.dart';
import 'package:expressfrontend/screens/weather/city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, apiMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: this.store,
        child: MaterialApp(
          theme: ThemeData.dark(),
          title: "Test app",
          routes: {AppRoutes.WeatherCity: (context) => CityScreen()},
        ));
  }
}
