// @dart=2.9

import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
  primaryColor: Color.fromARGB(255, 63, 51, 128),
  brightness: Brightness.light,
  accentColor: Color.fromARGB(255, 63, 51, 128),
  splashColor: Color.fromARGB(255, 63, 51, 128),
  highlightColor: Color.fromARGB(255, 63, 51, 128),
  fontFamily: 'zawgyi',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

ThemeData firstTD() => ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: Colors.white,
      brightness: Brightness.light,
    );
ThemeData secondTD() => ThemeData(
    fontFamily: 'Roboto',
    primarySwatch: Colors.white,
    brightness: Brightness.dark);
