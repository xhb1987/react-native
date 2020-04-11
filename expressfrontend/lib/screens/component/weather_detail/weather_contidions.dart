import 'package:flutter/material.dart';

class WeatherConditions extends StatelessWidget {
  final double windSpeed;
  final int humidity;
  final int predictability;

  WeatherConditions(this.windSpeed, this.humidity, this.predictability);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextStyle titleStyle = TextStyle(
        color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold);
    TextStyle contentStyle = TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle unitStyle = TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Wind",
              style: titleStyle,
            ),
            Text(
              this.windSpeed.round().toString(),
              style: contentStyle,
            ),
            Text(
              "mph",
              style: unitStyle,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Rain", style: titleStyle),
            Text(
              this.predictability.toString(),
              style: contentStyle,
            ),
            Text(
              "%",
              style: unitStyle,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Humidity", style: titleStyle),
            Text(
              this.humidity.toString(),
              style: contentStyle,
            ),
            Text(
              "%",
              style: unitStyle,
            )
          ],
        )
      ],
    );
  }
}
