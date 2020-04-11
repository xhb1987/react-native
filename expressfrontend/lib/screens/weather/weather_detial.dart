import 'package:carousel_slider/carousel_slider.dart';
import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/routes/routes.dart';
import 'package:expressfrontend/screens/component/empty_error.dart';
import 'package:expressfrontend/screens/component/weather_detail/city_title.dart';
import 'package:expressfrontend/screens/component/weather_detail/weather_detail_card.dart';
import 'package:expressfrontend/state/app_state.dart';
import 'package:expressfrontend/util/storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
  // final Object argument;
  // const AfterSplash({Key key, this.argument}) : super(key: key);
  final PageController _pageController = PageController();

  void handleInitialBuild(WeatherDetailScreenProps props) async {
    List<dynamic> cityDataList = await Storage.getValue("city_data_list");
    List<City> localCityDataList =
        List.from(cityDataList.map((city) => City.fromJSON(city)));

    if (localCityDataList != null && localCityDataList.isNotEmpty) {
      props.syncWithLocal(localCityDataList);
      localCityDataList.forEach((City city) {
        props.getCityWeather(city.woeId);
      });
      // props.getCityWeather(localCityDataList.first.woeId);
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
      builder: (context, props) {
        bool weatherRequestLoading = props.loading;
        Widget body;
        List<Weather> weatherDataList = props.weatherDataList;

        if (weatherDataList.isEmpty) {
          body = EmptyMessage();
        } else {
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
                    colors: [Colors.blue, Colors.blue[100]],
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
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return WeatherDetailCard(weatherDataList[index]);
                      },
                      itemCount: weatherDataList.length,
                      onPageChanged: (index) {
                        DateTime dt =
                            DateTime.parse(weatherDataList[index].time);
                        print(dt.toUtc());
                        print(index);
                      },
                      physics: ScrollPhysics(),
                    )),
              ],
            ),
            // child: PageView.builder(
            //   controller: _pageController,
            //   itemBuilder: (context, index) {
            //     return Text(cityDataList[index].title);
            //   },
            //   itemCount: cityDataList.length,
            //   onPageChanged: (index) {
            //     print(index);
            //   },
            //   physics: ScrollPhysics(),
            // ),
            // child: CarouselSlider(
            //   enableInfiniteScroll: false,
            //   height: MediaQuery.of(context).size.height,
            //   items: cityDataList.map((data) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //             width: MediaQuery.of(context).size.width,
            //             margin: EdgeInsets.only(right: 30),
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       color: Colors.white.withOpacity(0.1),
            //                       offset: Offset(0, 0),
            //                       spreadRadius: 5,
            //                       blurRadius: 2)
            //                 ],
            //                 color: Colors.transparent,
            //                 borderRadius: BorderRadius.all(Radius.circular(5))),
            //             child: Padding(
            //               padding: EdgeInsets.all(5),
            //               child: Column(
            //                 children: <Widget>[CityTitle(data.title)],
            //               ),
            //             ));
            //       },
            //     );
            //   }).toList(),
            //   onPageChanged: (index) {
            //     handleWhenPageChanged(index, props);
            //   },
            // ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.blue,
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

  WeatherDetailScreenProps(
      {this.getCityWeather,
      this.loading,
      this.weatherDataList,
      this.cties,
      this.syncWithLocal,
      this.cityDatas});
}

WeatherDetailScreenProps mapStateToScreen(Store<AppState> store) {
  return WeatherDetailScreenProps(
      cties: store.state.setting.cities,
      cityDatas: store.state.setting.cityDatas,
      getCityWeather: (int woeid) => store.dispatch(getCityWeather(woeid)),
      weatherDataList: store.state.weather.weather,
      loading: store.state.weather.loading,
      syncWithLocal: (List<City> cityList) =>
          store.dispatch(settingSyncWithLocal(cityList)));
}
