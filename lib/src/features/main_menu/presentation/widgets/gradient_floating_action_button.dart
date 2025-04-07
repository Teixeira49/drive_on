import 'package:flutter/material.dart';

import '../../../../core/config/styles/static_colors.dart';

class GradientFloatingActionButton extends StatelessWidget {
  const GradientFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      backgroundColor: Colors.transparent,
      onPressed: () {},
      elevation: ColorPalette.elevationScaleNone,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.blueGrey,
                offset: Offset(0, 2.0),
                blurRadius: 6.0,
              ),
            ],
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: ColorPalette.mainGradient)),
        child: const Icon(Icons.add),
      ),
    );
  }


}