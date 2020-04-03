import 'package:expressfrontend/actions/action.dart';
import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/models/setting/setting.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

Setting settingReducer(Setting state, FSA action) {
  Setting newState = state;

  switch (action.type) {
    case ADD_CITY:
      {
        if (!newState.cities.contains(action.payload)) {
          newState.cities.add(action.payload);
        }
        return newState;
      }
    default:
      return newState;
  }
}
