import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Time extends StatelessWidget {
  final DateTime _dateTime;

  Time(this._dateTime);

  String parseTime(DateTime dt) {
    DateFormat dateFormat = new DateFormat("h:mm a - EEE, MMM d, ''yy");
    String parsedTime = dateFormat.format(dt).toString();
    return parsedTime;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            parseTime(this._dateTime),
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
