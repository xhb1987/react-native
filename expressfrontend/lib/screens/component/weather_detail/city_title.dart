import 'package:flutter/material.dart';

class CityTitle extends StatelessWidget {
  final String cityTitle;

  CityTitle(this.cityTitle);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.cityTitle,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 34),
        )
      ],
    );
  }
}
