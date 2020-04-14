import 'package:expressfrontend/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

const CITY_QUARY_REQUST = "CITY_QUARY_REQUST";
const CITY_QUARY_SUCCESS = "CITY_QUARY_SUCCESS";
const CITY_QUARY_FAIL = "CITY_QUARY_FAIL";
const CLEAR_SEARCH_DATA = "CLEAR_SEARCH_DATA";

FSA clearSearchData() {
  return FSA(type: CLEAR_SEARCH_DATA);
}

RSAA getCityRequest(String city) {
  return RSAA(
      method: 'GET',
      endpoint:
          "https://yn4kddojti.execute-api.us-east-2.amazonaws.com/dev/weather/location/$city",
      types: [
        CITY_QUARY_REQUST,
        CITY_QUARY_SUCCESS,
        CITY_QUARY_FAIL
      ],
      headers: {
        'Content-Type': 'application/json',
      });
}

ThunkAction<AppState> getCity({String city = "Guangzhou"}) =>
    (Store<AppState> store) => store.dispatch(getCityRequest(city));
