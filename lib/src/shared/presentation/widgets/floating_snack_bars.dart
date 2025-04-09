import 'package:drive_on/src/core/config/styles/static_colors.dart';
import 'package:flutter/material.dart';

class FloatingWarningSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: ColorPalette.elevationScaleS,
        content: Row(
      children: [
        Icon(
          Icons.warning_amber,
          color: ColorPalette.warning,
        ),
        Expanded(child: Text(
          message,
          textAlign: TextAlign.center,
        ),),
        const SizedBox(
          width: 8,
        )
      ],
    )));
  }
}

class FloatingSnackBar {
  static void show(BuildContext context, String message,
      [IconData? iconData, Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: ColorPalette.elevationScaleS,
        content: Row(
      mainAxisAlignment: iconData != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: color,
          ),
        Expanded(child: Text(
          message,
          textAlign: TextAlign.center,
        ),),
        if (iconData != null)
          const SizedBox(
            width: 8,
          )
      ],
    )));
  }
}
