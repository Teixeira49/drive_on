import 'package:flutter/material.dart';

class FloatingWarningSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 5,
        content: Row(
      children: [
        Icon(
          Icons.warning_amber,
          color: Theme.of(context).colorScheme.secondary,
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
      elevation: 5,
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
