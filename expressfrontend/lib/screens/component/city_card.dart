import 'package:expressfrontend/theme.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final String cityName;

  CityCard(this.cityName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Opacity(
          opacity: 0.9,
          child: Card(
              color: Theme.of(context).cardColor,
              elevation: Theme.of(context).cardTheme.elevation,
              margin: Theme.of(context).cardTheme.margin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      this.cityName,
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )),
        ));
  }
}
