import 'package:expressfrontend/screens/search/search.dart';
import 'package:expressfrontend/screens/setting/city_list.dart';
import 'package:expressfrontend/screens/weather/weather_detial.dart';
import 'package:flutter/material.dart';

const Setting = '/search';
const CityList = '/city_list';
const WeatherDetial = '/';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CityList:
      return MaterialPageRoute(builder: (context) => CityListScreen());
    case Setting:
      return MaterialPageRoute(builder: (context) => SearchScreen());
    case WeatherDetial:
      // int arguments = settings.arguments;
      return MaterialPageRoute(builder: (context) => WeatherDetailScreen());
    default:
      return MaterialPageRoute(builder: (context) => WeatherDetailScreen());
  }
}
