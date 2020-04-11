import 'package:flutter/material.dart';

class CurrentTemp extends StatelessWidget {
  final double currentTemp;
  CurrentTemp(this.currentTemp);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.currentTemp.round().toString(),
          style: TextStyle(color: Colors.white, fontSize: 74),
        ),
        Text(
          " \u2103",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 34),
        )
      ],
    );
  }
}
