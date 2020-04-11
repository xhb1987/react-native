import 'package:expressfrontend/util/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherStateName extends StatelessWidget {
  final String weatherStateName;
  final String weatherStateAbbr;
  WeatherStateName(this.weatherStateName, this.weatherStateAbbr);

  // String icon = weatherStateIcons[weatherStateAbbr];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(
            weatherStateIcons[this.weatherStateAbbr],
            color: Colors.white,
            height: 24,
            width: 24,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              this.weatherStateName,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
