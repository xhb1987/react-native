import 'package:flutter/material.dart';

Map<String, Color> weatherStateBackgroundColors = {
  "sn": Colors.blueGrey[900],
  "sl": Colors.blueGrey[900],
  "h": Colors.blueGrey[900],
  "t": Colors.grey[850],
  "hr": Colors.grey[800],
  "lr": Colors.grey[700],
  "s": Colors.grey[900],
  "hc": Colors.blueGrey[600],
  "lc": Colors.blueGrey[500],
  "c": Colors.blue,
};

List<Color> getLinearGradient(String state) {
  Map<String, List<Color>> linear = {
    "sn": [Colors.blueGrey[900], Colors.blueGrey[800]],
    "sl": [Colors.blueGrey[900], Colors.blueGrey[800]],
    "h": [Colors.blueGrey[900], Colors.blueGrey[800]],
    "t": [Colors.grey[850], Colors.grey[700]],
    "hr": [Colors.grey[800], Colors.grey[700]],
    "lr": [Colors.grey[700], Colors.grey[600]],
    "s": [Colors.grey[900], Colors.grey[800]],
    "hc": [Colors.blueGrey[600], Colors.blueGrey],
    "lc": [Colors.blueGrey, Colors.blueGrey[400]],
    "c": [Colors.blue, Colors.blue[100]],
  };

  return linear[state];
}

// 'assets/notfound.svg', // uncomment to test an asset that doesn't exist.
