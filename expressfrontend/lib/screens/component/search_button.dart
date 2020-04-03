import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final bool isSearchIcon;
  final Function onButtonClick;

  SearchButton(this.isSearchIcon, this.onButtonClick);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      icon: Icon(
        this.isSearchIcon ? Icons.close : Icons.search,
        color: Colors.white,
      ),
      onPressed: onButtonClick,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
