import 'package:flutter/material.dart';

abstract class ColorPalette {

  static List<Color> authGradient = [
    Colors.white,
    Colors.grey[50]!,
    Colors.grey[50]!,
    Colors.cyan,
    Colors.blue
  ];

  static List<Color> mainGradient = [
    Colors.blue,
    Colors.cyanAccent,
  ];

  static double elevationScaleNone = 0;
  static double elevationScaleS = 5;
  static double elevationScaleM = 10;
}