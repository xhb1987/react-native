import 'package:carousel_slider/carousel_slider.dart';
import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/routes/routes.dart';
import 'package:expressfrontend/screens/component/empty_error.dart';
import 'package:expressfrontend/state/app_state.dart';
import 'package:expressfrontend/util/storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:splashscreen/splashscreen.dart';

class WeatherDetailScreen extends StatefulWidget {
  @override
  _WeatherDetailScreen createState() => new _WeatherDetailScreen();
}

class _WeatherDetailScreen extends State<WeatherDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      navigateAfterFuture: Storage.isReady().then((isReady) {
        return Future.delayed(Duration(seconds: 2), () {
          if (isReady) {
            return new AfterSplash();
          }

          return null;
        });
      }),
      title: new Text(
        'Little weather forecast',
        style: TextStyle(color: Colors.white, fontSize: 36),
        textAlign: TextAlign.center,
      ),
      gradientBackground: LinearGradient(
          colors: [Colors.blue, Colors.blue[100]],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      seconds: 2,
      loaderColor: Colors.transparent,
    );
  }
}

class AfterSplash extends StatelessWidget {
  final Object argument;
  const AfterSplash({Key key, this.argument}) : super(key: key);

  void handleInitialBuild(WeatherDetailScreenProps props) async {
    List<dynamic> cityDataList = await Storage.getValue("city_data_list");
    List<City> localCityDataList =
        List.from(cityDataList.map((city) => City.fromJSON(city)));

    if (localCityDataList != null && localCityDataList.isNotEmpty) {
      props.syncWithLocal(localCityDataList);
      props.getCityWeather(localCityDataList.first.woeId);
    }
  }

  void handleWhenPageChanged(int index, WeatherDetailScreenProps props) {
    City city = props.cityDatas[index];
    if (!props.weather.any((Weather weather) => weather.title == city.title)) {
      props.getCityWeather(city.woeId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WeatherDetailScreenProps>(
      converter: (store) => mapStateToScreen(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        bool weatherRequestLoading = props.loading;
        Widget body;
        List<City> cityDataList = props.cityDatas;
        // if (weatherRequestLoading) {
        //   body = Center(child: CircularProgressIndicator());
        // } else {
        // Weather weather = props.weather;
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

        if (cityDataList.isEmpty) {
          body = EmptyMessage();
        } else {
          body = CarouselSlider(
            enableInfiniteScroll: false,
            height: MediaQuery.of(context).size.height,
            items: cityDataList.map((data) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Text(
                        data.title,
                        style: TextStyle(fontSize: 16.0),
                      ));
                },
              );
            }).toList(),
            onPageChanged: (index) {
              handleWhenPageChanged(index, props);
            },
          );
        }

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
  final List<Weather> weather;
  final List<String> cties;
  final Function syncWithLocal;
  final List<City> cityDatas;

  WeatherDetailScreenProps(
      {this.getCityWeather,
      this.loading,
      this.weather,
      this.cties,
      this.syncWithLocal,
      this.cityDatas});
}

WeatherDetailScreenProps mapStateToScreen(Store<AppState> store) {
  return WeatherDetailScreenProps(
      cties: store.state.setting.cities,
      cityDatas: store.state.setting.cityDatas,
      getCityWeather: (int woeid) => store.dispatch(getCityWeather(woeid)),
      weather: store.state.weather.weather,
      loading: store.state.weather.loading,
      syncWithLocal: (List<City> cityList) =>
          store.dispatch(settingSyncWithLocal(cityList)));
}
