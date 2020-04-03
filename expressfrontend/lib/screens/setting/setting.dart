import 'dart:convert';

import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/app_state.dart';
import 'package:expressfrontend/models/weather/city.dart';
import 'package:expressfrontend/screens/component/city_card.dart';
import 'package:expressfrontend/screens/component/search_bar.dart';
import 'package:expressfrontend/util/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:redux/redux.dart';

class SettingScreen extends StatelessWidget {
  updateLocalCityList(String city) {
    List<dynamic> localCityList = Storage.getValue("city_list") ?? [];
    if (localCityList != null && !localCityList.contains(city)) {
      localCityList.add(city);
      Storage.setValue("city_list", json.encode(localCityList));
    }
  }

  initBuild() {
    List<dynamic> localCityList = Storage.getValue("city_list") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, CityScreenProps>(
      converter: (store) => mapStateToScreen(store),
      onInitialBuild: initBuild(),
      builder: (context, props) {
        List<City> cityData = props.city;
        bool cityLoading = props.loading;
        Widget body;

        if (cityLoading) {
          body = Center(child: CircularProgressIndicator());
        } else {
          body = ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: cityData.length ?? 0,
            separatorBuilder: (context, i) => Divider(),
            itemBuilder: (context, i) {
              City data = cityData[i];
              return InkWell(
                  child: CityCard(data.title),
                  onTap: () {
                    updateLocalCityList(data.title);
                    props.addCity(data.title);
                  });
            },
          );
        }
        return Scaffold(
            body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue[900], Colors.blue[400]])),
            ),
            Positioned(
              top: 90.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: body,
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                title: SearchBar(),
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class CityScreenProps {
  final Function getCity;
  final List<City> city;
  final bool loading;
  final List<String> cities;
  final Function addCity;

  CityScreenProps(
      {this.getCity, this.city, this.loading, this.cities, this.addCity});
}

CityScreenProps mapStateToScreen(Store<AppState> store) {
  return CityScreenProps(
      getCity: () => store.dispatch(getCity()),
      city: store.state.weather.city.data,
      loading: store.state.weather.city.loading,
      cities: store.state.setting.cities,
      addCity: (String city) => store.dispatch(addCity(city)));
}
