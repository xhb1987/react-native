import 'dart:convert';

import 'package:expressfrontend/actions/action.dart';
import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/models/city/city.dart';
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
        if (!newState.cityDatas.contains(action.payload)) {
          newState.cityDatas.add(action.payload);
          List<dynamic> cityDatas = newState.cityDatas
              .map((city) => {
                    'title': city.title,
                    'location_type': city.locationType,
                    'woeid': city.woeId,
                    'latt_long': city.lattLong
                  })
              .toList();
          Storage.setValue("city_data_list", cityDatas);
        }
        return newState;
      }
    case SETTING_SYNC_WITH_LOCAL:
      {
        newState.syncWithLocal();
        return newState;
      }
    case DELETE_CITY:
      {
        newState.cities.remove(action.payload);
        newState.cityDatas
            .removeWhere((City city) => city.title == action.payload);
        Storage.setValue("city_list", newState.cities);
        Storage.setValue("city_data_list", newState.cityDatas);
        return newState;
      }
    default:
      return newState;
  }
}
