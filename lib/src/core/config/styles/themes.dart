import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'gotham',
      primaryColor: const Color.fromRGBO(77, 5, 166, 1.0),
      scaffoldBackgroundColor: Colors.white,
      splashColor: const Color.fromRGBO(87, 183, 255, 1.0),
      iconTheme: const IconThemeData(color: Color.fromRGBO(58, 58, 58, 1.0)),
      appBarTheme: const AppBarTheme(
        elevation: 7.5,
        backgroundColor: Color.fromRGBO(20, 154, 255, 1.0),
        shadowColor: Color.fromRGBO(97, 155, 201, 0.7490196078431373),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color.fromRGBO(255, 255, 255, 1.0),
            fontFamily: "gotham"),
        iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 1.0)),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'gotham',
      primaryColor: const Color.fromRGBO(77, 5, 166, 1.0),
      scaffoldBackgroundColor: Colors.black,
      splashColor: const Color.fromRGBO(87, 183, 255, 1.0),
      iconTheme: const IconThemeData(color: Color.fromRGBO(58, 58, 58, 1.0)),
      appBarTheme: const AppBarTheme(
        elevation: 7.5,
        backgroundColor: Color.fromRGBO(20, 154, 255, 1.0),
        shadowColor: Color.fromRGBO(97, 155, 201, 0.7490196078431373),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color.fromRGBO(0, 0, 0, 1.0),
            fontFamily: "gotham"),
        iconTheme: IconThemeData(color: Color.fromRGBO(19, 19, 19, 1.0)),
      ),
    );
  }
}
