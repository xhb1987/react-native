import 'package:expressfrontend/models/city/city.dart';

class SearchState {
  List<City> cityDatas = new List();
  dynamic error;
  bool loading;

  SearchState({this.cityDatas, this.error, this.loading});

  factory SearchState.initial() =>
      SearchState(cityDatas: [], loading: false, error: null);
}
