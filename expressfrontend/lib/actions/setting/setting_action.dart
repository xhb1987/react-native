import 'package:expressfrontend/actions/action.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

const ADD_CITY = "ADD_CITY";

FSA addCity(String city) {
  return FSA(type: ADD_CITY, payload: city);
}
