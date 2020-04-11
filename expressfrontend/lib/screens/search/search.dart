import 'package:expressfrontend/actions/search/search_actions.dart';
import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/screens/component/list_item.dart';
import 'package:expressfrontend/screens/component/search_bar.dart';
import 'package:expressfrontend/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SearchScreen extends StatelessWidget {
  onInit(SearchScreenProps props) {
    props.clearSearchData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, SearchScreenProps>(
      converter: (store) => mapStateToScreen(store),
      onInitialBuild: (props) => onInit(props),
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
                  child: ListItem(data.title),
                  onTap: () {
                    props.addCity(data.title);
                    props.addCityData(data);
                    props.getWeatherDetail(data.woeId);
                    props.clearSearchData();
                    Navigator.of(context).pop();
                  });
            },
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: SearchBar(),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black54),
            ),
            body: body);
      },
    );
  }
}

class SearchScreenProps {
  final Function getCity;
  final List<City> city;
  final bool loading;
  final List<String> cities;
  final Function addCity;
  final Function addCityData;
  final Function clearSearchData;
  final Function getWeatherDetail;

  SearchScreenProps(
      {this.getCity,
      this.city,
      this.loading,
      this.cities,
      this.addCity,
      this.addCityData,
      this.clearSearchData,
      this.getWeatherDetail});
}

SearchScreenProps mapStateToScreen(Store<AppState> store) {
  return SearchScreenProps(
      getCity: () => store.dispatch(getCity()),
      city: store.state.search.cityDatas,
      loading: store.state.search.loading,
      cities: store.state.setting.cities,
      getWeatherDetail: (int woeid) =>
          store.dispatch(getCityWeatherRequest(woeid)),
      clearSearchData: () => store.dispatch(clearSearchData()),
      addCity: (String city) => store.dispatch(addCity(city)),
      addCityData: (City cityData) => store.dispatch(addCityData(cityData)));
}
