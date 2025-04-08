import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ColorPalette {
  static List<Color> authGradientLight = [
    Colors.white,
    Colors.grey[50]!,
    Colors.grey[50]!,
    Colors.cyan,
    Colors.blue
  ];

  static List<Color> authGradientDark = [
    Colors.black,
    Colors.black54,
    Colors.black54,
    Colors.cyan,
    Colors.blue
  ];

  static List<Color> mainGradient = [
    Colors.blue,
    Colors.cyanAccent,
  ];

  static Color boldTextColored = Colors.blue;

  static Color contactsCard = Colors.greenAccent.withOpacity(0.3);

  static Color receiveMoney = Colors.green;
  static Color sendMoney = Colors.red;

  static List<Color> alertGradient = [
    Colors.red,
    Colors.orangeAccent,
  ];

  static double elevationScaleNone = 0;
  static double elevationScaleS = 5;
  static double elevationScaleM = 10;
}
