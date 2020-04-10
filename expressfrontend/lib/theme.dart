import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    primaryColor: Colors.blue[100],
    cardColor: Colors.blue[800],
    cardTheme: CardTheme(
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.all(3)),
    textTheme: TextTheme(
        display1: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        title: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        )));
