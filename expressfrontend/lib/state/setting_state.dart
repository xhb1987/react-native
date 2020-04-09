import 'dart:convert';

import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/util/city_helper.dart';
import 'package:expressfrontend/util/storage.dart';

class SettingState {
  List<String> cities = new List();
  List<City> cityDatas = new List();

  SettingState({this.cities, this.cityDatas});

  syncWithLocal() async {
    var cities = await Storage.getValue("city_list");

    List<dynamic> cityDatas = await Storage.getValue("city_data_list");
    // print(items as List);
    print(cityDatas);
    this.cities =
        cities != null ? List.from((cities as List).map((item) => item)) : [];

    this.cityDatas = List.from(cityDatas.map((city) => City.fromJSON(city)));
  }

  factory SettingState.initial() => SettingState(cities: [], cityDatas: []);
}
