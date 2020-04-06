import 'package:expressfrontend/actions/action.dart';
import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/state/setting_state.dart';
import 'package:expressfrontend/util/storage.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

SettingState settingReducer(SettingState state, FSA action) {
  SettingState newState = state;
  switch (action.type) {
    case ADD_CITY:
      {
        if (!newState.cities.contains(action.payload)) {
          newState.cities.add(action.payload);
          Storage.setValue("city_list", newState.cities);
        }
        return newState;
      }
    case ADD_CITY_DATA:
      {
        return newState;
      }
    case SETTING_SYNC_WITH_LOCAL:
      {
        newState.syncWithLocal();
        return newState;
      }
    default:
      return newState;
  }
}
