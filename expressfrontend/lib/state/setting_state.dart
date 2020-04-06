import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/util/storage.dart';

class SettingState {
  List<String> cities = new List();
  List<City> cityDatas = new List();

  SettingState({this.cities, this.cityDatas});

  syncWithLocal() async {
    var cities = await Storage.getValue("city_list");
    var cityDatas = await Storage.getValue("city_data_list");
    // print(items as List);
    this.cities =
        cities != null ? List.from((cities as List).map((item) => item)) : [];
    this.cityDatas = cityDatas != null
        ? List.from((cityDatas as List).map((item) => item))
        : [];
  }

  factory SettingState.initial() => SettingState(cities: [], cityDatas: []);
}
