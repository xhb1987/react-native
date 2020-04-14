import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/routes/routes.dart';
import 'package:expressfrontend/screens/component/empty_error.dart';
import 'package:expressfrontend/screens/component/weather_detail/weather_detail_card.dart';
import 'package:expressfrontend/state/app_state.dart';
import 'package:expressfrontend/util/backgrounds.dart';
import 'package:expressfrontend/util/storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
        'Little weather',
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
  // final Object argument;
  // const AfterSplash({Key key, this.argument}) : super(key: key);
  final PageController _pageController = PageController(initialPage: 0);
  final RefreshController _refreshController = RefreshController();

  void handleInitialBuild(WeatherDetailScreenProps props) async {
    List<dynamic> cityDataList = await Storage.getValue("city_data_list");

    if (cityDataList != null) {
      List<City> localCityDataList =
          List.from(cityDataList.map((city) => City.fromJSON(city)));

      if (localCityDataList != null && localCityDataList.isNotEmpty) {
        props.syncWithLocal(localCityDataList);
        localCityDataList.forEach((City city) async {
          var weather = await Storage.getValue(city.title.replaceAll(" ", ''))
              as Map<String, dynamic>;

          Weather localWeather = Weather.fromJson(weather);

          if (localWeather != null) {
            props.addCityWeatherDetail(localWeather);

            if (DateTime.now().difference(localWeather.updatedTime).inHours >
                1) {
              props.getCityWeather(city.woeId);
            }
          } else {
            props.getCityWeather(city.woeId);
          }
        });
        // props.getCityWeather(localCityDataList.first.woeId);
      }
    }
  }

  void handleWhenPageChanged(int index, WeatherDetailScreenProps props) {
    City city = props.cityDatas[index];
    if (!props.weatherDataList
        .any((Weather weather) => weather.title == city.title)) {
      props.getCityWeather(city.woeId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WeatherDetailScreenProps>(
      converter: (store) => mapStateToScreen(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      onDidChange: (props) {
        if (props.index < props.weatherDataList.length) {
          this._pageController.animateToPage(props.index,
              duration: Duration(milliseconds: 200),
              curve: Curves.linearToEaseOut);
        }
      },
      builder: (context, props) {
        bool weatherRequestLoading = props.loading;
        Widget body;
        int index = props.index;
        List<Weather> weatherDataList = props.weatherDataList;
        List<City> cityDataList = props.cityDatas;
        Color backgroundColor;
        List<Color> cardBackgroundColor;

        if (weatherRequestLoading == false) {
          this._refreshController.refreshCompleted();
        }

        if (weatherDataList.isEmpty) {
          body = EmptyMessage();
        } else {
          String weatherStateAbbr = 'c';

          if (weatherDataList[index].consolidatedWeather.isNotEmpty) {
            weatherStateAbbr = weatherDataList[index]
                .consolidatedWeather
                .first
                .weatherStateAbbr;
          }

          backgroundColor = weatherStateBackgroundColors[weatherStateAbbr];
          cardBackgroundColor = getLinearGradient(weatherStateAbbr);

          SmoothPageIndicator indicator = weatherDataList.length > 1
              ? SmoothPageIndicator(
                  controller: _pageController,
                  count: weatherDataList.length,
                  effect: WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.white,
                      dotHeight: 10,
                      dotWidth: 10),
                )
              : null;
          body = Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: cardBackgroundColor,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: indicator,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SmartRefresher(
                      controller: this._refreshController,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) =>
                            props.updateWeatherIndex(index),
                        itemBuilder: (context, index) {
                          return WeatherDetailCard(weatherDataList[index]);
                        },
                        itemCount: weatherDataList.length,
                        physics: ScrollPhysics(),
                      ),
                      onRefresh: () async {
                        props.getCityWeather(cityDataList[props.index].woeId);
                      },
                      header: WaterDropHeader(
                        waterDropColor: Colors.white,
                        idleIcon: Icon(
                          Icons.autorenew,
                          color: Colors.white,
                        ),
                        refresh: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blue[200],
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                        completeDuration: Duration(seconds: 0),
                      ),
                    )),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: backgroundColor ?? Colors.blue,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(context, CityList))
            ],
          ),
          body: body,
        );
      },
    );
  }
}
// TODO
// ADD ATTRIBUTE the icon "heart" is provided by loading.io
// ADD ATTRIBUTE flaticon "Icon made by Pixel perfect from www.flaticon.com"

class WeatherDetailScreenProps {
  final bool loading;
  final Function getCityWeather;
  final List<Weather> weatherDataList;
  final List<String> cties;
  final Function syncWithLocal;
  final List<City> cityDatas;
  final Function addCityWeatherDetail;
  final Function updateWeatherIndex;
  final int index;

  WeatherDetailScreenProps(
      {this.getCityWeather,
      this.loading,
      this.weatherDataList,
      this.cties,
      this.syncWithLocal,
      this.cityDatas,
      this.addCityWeatherDetail,
      this.updateWeatherIndex,
      this.index});
}

WeatherDetailScreenProps mapStateToScreen(Store<AppState> store) {
  return WeatherDetailScreenProps(
      index: store.state.weather.index,
      cties: store.state.setting.cities,
      cityDatas: store.state.setting.cityDatas,
      getCityWeather: (int woeid) => store.dispatch(getCityWeather(woeid)),
      weatherDataList: store.state.weather.weather,
      loading: store.state.weather.loading,
      addCityWeatherDetail: (Weather weather) =>
          store.dispatch(addCityWeatherDetail(weather)),
      syncWithLocal: (List<City> cityList) =>
          store.dispatch(settingSyncWithLocal(cityList)),
      updateWeatherIndex: (int index) =>
          store.dispatch(updateWeatherIndex(index)));
}
