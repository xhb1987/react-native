import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/app_state.dart';
import 'package:expressfrontend/models/weather/city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CityScreen extends StatelessWidget {
  void handleInitialBuild(CityScreenProps props) {
    props.getCity();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CityScreenProps>(
      converter: (store) => mapStateToScreen(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        List<City> cityData = props.city;
        bool cityLoading = props.loading;
        print(props.loading);
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(data.title),
                      Text(data.lattLong),
                      Text(data.locationType),
                      Text(data.woeId.toString())
                    ]),
                onTap: () => print(data.title),
              );
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("City"),
          ),
          body: body,
        );
      },
    );
  }
}

class CityScreenProps {
  final Function getCity;
  final List<City> city;
  final bool loading;

  CityScreenProps({this.getCity, this.city, this.loading});
}

CityScreenProps mapStateToScreen(Store<AppState> store) {
  print(store);
  return CityScreenProps(
      getCity: () => store.dispatch(getCity()),
      city: store.state.weather.city.data,
      loading: store.state.weather.city.loading);
}
