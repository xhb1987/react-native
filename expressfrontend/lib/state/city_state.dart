import 'package:expressfrontend/models/city/city.dart';

class CityState {
  dynamic error;
  bool loading;
  List<City> data;
  String searchCity;

  CityState({this.error, this.loading, this.data, this.searchCity});

  factory CityState.initial() =>
      CityState(error: null, loading: false, data: [], searchCity: "");
}
