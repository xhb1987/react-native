import 'package:carousel_slider/carousel_slider.dart';
import 'package:expressfrontend/models/app_state.dart';
import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/routes/routes.dart';
import 'package:expressfrontend/util/storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class WeatherDetailScreen extends StatelessWidget {
  final Object argument;
  const WeatherDetailScreen({Key key, this.argument}) : super(key: key);

  void handleInitialBuild(WeatherDetailScreenProps props) {
    // List<dynamic> cities = Storage.getValue("city_list");
    // this.argument ?? props.getCityWeather(this.argument);
  }

  initBuild() {
    List<dynamic> localCityList = Storage.getValue("city_list") ?? [];
    print(localCityList);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WeatherDetailScreenProps>(
      converter: (store) => mapStateToScreen(store),
      onInit: initBuild(),
      onDidChange: initBuild(),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        bool weatherRequestLoading = props.loading;
        Widget body;
        // if (weatherRequestLoading) {
        //   body = Center(child: CircularProgressIndicator());
        // } else {
        Weather weather = props.weather;
        // body = ListView.separated(
        //   padding: const EdgeInsets.all(16.0),
        //   itemCount: weather.consolidatedWeather.length ?? 0,
        //   separatorBuilder: (context, i) => Divider(),
        //   itemBuilder: (context, i) {
        //     WeatherDetail data = weather.consolidatedWeather.length > 0
        //         ? weather.consolidatedWeather[i]
        //         : null;
        //     if (data != null) {
        //       return InkWell(
        //         child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Text(data.maxTemp.toStringAsFixed(2)),
        //               Text(data.minTemp.toStringAsFixed(2)),
        //               Text(data.humidity.toString()),
        //               Text(data.weatherStateName)
        //             ]),
        //       );
        //     } else {
        //       return Container(
        //         color: Colors.black,
        //       );
        //     }
        //   },
        // );
        body = CarouselSlider(
          height: MediaQuery.of(context).size.height,
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        );

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.location_city),
                  onPressed: () => Navigator.pushNamed(context, CityList))
            ],
          ),
          body: body,
        );
      },
    );
  }
}

class WeatherDetailScreenProps {
  final bool loading;
  final Function getCityWeather;
  final Weather weather;
  final List<String> cties;

  WeatherDetailScreenProps(
      {this.getCityWeather, this.loading, this.weather, this.cties});
}

WeatherDetailScreenProps mapStateToScreen(Store<AppState> store) {
  return WeatherDetailScreenProps(
      cties: store.state.setting.cities,
      getCityWeather: (int woeid) => store.dispatch(getCityWeather(woeid)),
      weather: store.state.weather.weatherDetail.weather,
      loading: store.state.weather.weatherDetail.loading);
}
