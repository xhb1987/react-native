import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String itemName;

  ListItem(this.itemName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        this.itemName,
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}
