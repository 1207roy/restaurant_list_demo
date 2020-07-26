import 'package:flutter/material.dart';

final String fontJosefinSans = 'josefinsans';

final ThemeData appTheme = ThemeData(
  appBarTheme: appBarTheme,
  fontFamily: fontJosefinSans,
);

final AppBarTheme appBarTheme = AppBarTheme(
  elevation: 0.0,
  color: Colors.transparent,
  textTheme: TextTheme(
    headline6: TextStyle(
        color: Colors.black,
        fontFamily: fontJosefinSans,
        fontSize: 18,
        fontWeight: FontWeight.bold),
  ),
);
