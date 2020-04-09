import 'package:expressfrontend/actions/search/search_actions.dart';
import 'package:expressfrontend/actions/setting/setting_action.dart';
import 'package:expressfrontend/routes/routes.dart';
import 'package:expressfrontend/screens/component/city_card.dart';
import 'package:expressfrontend/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CityListScreen extends StatelessWidget {
  initBuild() {
    // List<dynamic> localCityList = Storage.getValue("city_list") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, CityListScreenProps>(
        converter: (store) => mapStateToScreen(store),
        onInitialBuild: initBuild(),
        builder: (context, props) {
          List<String> cities = props.cities;
          Widget body = ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: cities.length ?? 0,
            separatorBuilder: (context, i) => Divider(),
            itemBuilder: (context, i) {
              String city = cities[i];
              return GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                city,
                                style: Theme.of(context).textTheme.display1,
                              ),
                              FlatButton(
                                  onPressed: () {
                                    props.deleteCity(city);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.delete),
                                      Text("Delete")
                                    ],
                                  )),
                            ],
                          ),
                        );
                      });
                },
                child: InkWell(child: CityCard(city)),
              );
            },
          );
          return Scaffold(
            body: body,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => Navigator.pushNamed(context, Setting))
              ],
            ),
          );
        });
  }
}

class CityListScreenProps {
  final List<String> cities;
  final Function deleteCity;

  CityListScreenProps({this.cities, this.deleteCity});
}

CityListScreenProps mapStateToScreen(Store<AppState> store) {
  return CityListScreenProps(
      cities: store.state.setting.cities,
      deleteCity: (String city) => store.dispatch(deleteCity(city)));
}
