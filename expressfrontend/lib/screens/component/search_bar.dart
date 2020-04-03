import 'package:expressfrontend/actions/weather/weather_actions.dart';
import 'package:expressfrontend/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchBarProps>(
        converter: (store) => mapStateToScreen(store),
        builder: (context, props) {
          return TextField(
            style: TextStyle(color: Colors.white),
            autofocus: true,
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: "Search for city",
                hintStyle: TextStyle(color: Colors.white)),
            controller: _controller,
            // onEditingComplete: ,
            onSubmitted: (city) => props.getCity(city),
          );
        });
  }
}

class SearchBarProps {
  final Function getCity;

  SearchBarProps({
    this.getCity,
  });
}

SearchBarProps mapStateToScreen(Store<AppState> store) {
  return SearchBarProps(
    getCity: (String city) => store.dispatch(getCity(city: city)),
  );
}
