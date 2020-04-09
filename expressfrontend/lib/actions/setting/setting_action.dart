import 'package:expressfrontend/models/city/city.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

const ADD_CITY = "ADD_CITY";
const ADD_CITY_DATA = "ADD_CITY_DATA";
const SETTING_SYNC_WITH_LOCAL = "SETTING_SYNC_WITH_LOCAL";

const DELETE_CITY = 'DELETE_CITY';

FSA addCity(String city) {
  return FSA(type: ADD_CITY, payload: city);
}

FSA addCityData(City cityData) {
  return FSA(type: ADD_CITY_DATA, payload: cityData);
}

FSA settingSyncWithLocal() {
  return FSA(type: SETTING_SYNC_WITH_LOCAL);
}

FSA deleteCity(String city) {
  return FSA(type: DELETE_CITY, payload: city);
}
