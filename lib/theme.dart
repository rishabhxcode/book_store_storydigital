import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData defaultTheme = ThemeData(
    primarySwatch: Colors.amber,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber,
        textTheme: TextTheme(),
        iconTheme: IconThemeData(
          color: Colors.white,
        )),
  );
}
