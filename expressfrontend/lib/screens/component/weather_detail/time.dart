import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Time extends StatelessWidget {
  final DateTime updatedTime;

  Time(this.updatedTime);

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
            "Updated on " + parseTime(this.updatedTime),
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
