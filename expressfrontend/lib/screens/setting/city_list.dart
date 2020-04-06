import 'package:expressfrontend/actions/search/search_actions.dart';
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
              return InkWell(child: CityCard(city));
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

  CityListScreenProps({
    this.cities,
  });
}

CityListScreenProps mapStateToScreen(Store<AppState> store) {
  return CityListScreenProps(
    cities: store.state.setting.cities,
  );
}
