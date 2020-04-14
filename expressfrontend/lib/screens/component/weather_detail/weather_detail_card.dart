import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/screens/component/weather_detail/city_title.dart';
import 'package:expressfrontend/screens/component/weather_detail/current_temp.dart';
import 'package:expressfrontend/screens/component/weather_detail/time.dart';
import 'package:expressfrontend/screens/component/weather_detail/weather_contidions.dart';
import 'package:expressfrontend/screens/component/weather_detail/weather_state_name.dart';
import 'package:flutter/material.dart';

class WeatherDetailCard extends StatelessWidget {
  final Weather _weather;
  WeatherDetailCard(this._weather);

  @override
  Widget build(BuildContext context) {
    Widget detailCard = this._weather.consolidatedWeather.isNotEmpty
        ? Container(
            child: Column(
              children: <Widget>[
                CurrentTemp(this._weather.consolidatedWeather.first.theTemp),
                WeatherStateName(
                    this._weather.consolidatedWeather.first.weatherStateName,
                    this._weather.consolidatedWeather.first.weatherStateAbbr),
                Divider(),
                WeatherConditions(
                    this._weather.consolidatedWeather.first.windSpeed,
                    this._weather.consolidatedWeather.first.humidity,
                    this._weather.consolidatedWeather.first.predictability)
              ],
            ),
          )
        : Container();
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  CityTitle(this._weather.title),
                  Time(this._weather.updatedTime),
                ],
              ),
            ),
            detailCard
          ],
        ));
  }
}
