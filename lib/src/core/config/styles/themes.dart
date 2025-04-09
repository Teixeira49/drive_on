import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
        brightness: Brightness.light,
        fontFamily: 'gotham',
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        splashColor: const Color.fromRGBO(87, 183, 255, 1.0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(58, 58, 58, 1.0)),
        appBarTheme: const AppBarTheme(
          //elevation: 7.5,
          backgroundColor: Colors.transparent,
          //Color.fromRGBO(20, 154, 255, 1.0),
          //shadowColor: Color.fromRGBO(97, 155, 201, 0.7490196078431373),
          titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Color.fromRGBO(255, 255, 255, 1.0),
              fontFamily: "gotham"),
          iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 1.0)),
        ),
        navigationBarTheme: NavigationBarThemeData(
          elevation: 0,
          indicatorColor: Colors.blue.withOpacity(0.45),
          backgroundColor: Colors.white,
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.black87,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.blue,
            circularTrackColor: Color.fromRGBO(15, 193, 247, 1.0)),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: Color.fromRGBO(58, 58, 58, 1.0),
              fontWeight: FontWeight.w700,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent, width: 1)),
            fillColor: Colors.white70,
            filled: true),
        textSelectionTheme: const TextSelectionThemeData( cursorColor: Colors.blue)
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
        snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.white70,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.blue,
            circularTrackColor: Color.fromRGBO(15, 193, 247, 1.0)));
  }
}
