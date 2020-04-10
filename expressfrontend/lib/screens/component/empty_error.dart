import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "No city added yet, please add at least one city",
            style: TextStyle(color: Theme.of(context).errorColor, fontSize: 18),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
