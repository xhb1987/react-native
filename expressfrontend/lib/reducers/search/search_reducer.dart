import 'dart:convert';

import 'package:expressfrontend/actions/action.dart';
import 'package:expressfrontend/actions/search/search_actions.dart';
import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/models/response-message/response_message.dart';
import 'package:expressfrontend/state/search_state.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

SearchState searchReducer(SearchState state, FSA action) {
  SearchState newState = state;
  switch (action.type) {
    case CLEAR_SEARCH_DATA:
      newState.error = false;
      newState.cityDatas = [];
      newState.loading = false;
      return newState;
    case CITY_QUARY_REQUST:
      newState.error = false;
      newState.cityDatas = [];
      newState.loading = true;
      return newState;
    case CITY_QUARY_SUCCESS:
      newState.error = false;
      newState.loading = false;
      newState.cityDatas = cityFromJson(action.payload);
      return newState;
    case CITY_QUARY_FAIL:
      newState.error = true;
      newState.cityDatas = [];
      newState.loading = false;
      return newState;
    default:
      return newState;
  }
}

List<City> cityFromJson(dynamic payload) {
  ResponseMessage responseMessage =
      ResponseMessage.fromJSON(json.decode(payload));

  final parsed =
      List<Map<String, dynamic>>.from(json.decode(responseMessage.data));
  List<City> cities = parsed.map((p) => City.fromJSON(p)).toList();

  return cities;
}
