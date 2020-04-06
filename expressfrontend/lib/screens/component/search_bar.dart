import 'package:expressfrontend/actions/search/search_actions.dart';
import 'package:expressfrontend/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchBarProps>(
        converter: (store) => mapStateToScreen(store),
        builder: (context, props) {
          return TextField(
              style: TextStyle(color: Colors.black),
              autofocus: true,
              decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: InputBorder.none,
                  hintText: "Search for city",
                  hintStyle: TextStyle(color: Colors.black)),
              // onEditingComplete: ,
              onChanged: (val) => props.getCity(val));
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
