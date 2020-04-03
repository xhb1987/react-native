import 'package:expressfrontend/screens/component/search_bar.dart';
import 'package:expressfrontend/screens/component/search_button.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatefulWidget with PreferredSizeWidget {
  @override
  _MenuBar createState() => _MenuBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MenuBar extends State<MenuBar> {
  // MyBar();
  bool _isShowSearchBar = false;

  void _toggleSearch() {
    setState(() {
      this._isShowSearchBar = !this._isShowSearchBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: SearchButton(this._isShowSearchBar, _toggleSearch),
      title: this._isShowSearchBar ? SearchBar() : null,
      // actions: <Widget>[
      //   Padding(
      //     padding: EdgeInsets.only(right: 10),
      //     child: GestureDetector(
      //       onTap: () {},
      //       child: Icon(Icons.menu),
      //     ),
      //   )
      // ],
    );
  }
}
