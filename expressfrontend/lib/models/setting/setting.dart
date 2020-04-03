import 'package:expressfrontend/util/storage.dart';

class Setting {
  List<String> cities = new List();
  Setting({List<String> cities}) {
    this.cities = Storage.getValue("city_list") as List<String> ?? cities;
  }

  factory Setting.initial() => Setting(cities: []);
}
