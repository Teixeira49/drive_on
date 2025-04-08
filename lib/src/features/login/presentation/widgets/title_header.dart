import 'package:drive_on/src/core/config/styles/static_colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../core/config/styles/margin.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: ColorPalette.mainGradient
        ).createShader(bounds),
        child: const Icon(
            Icons.wallet,
            size: AppSpacing.xl,
          )),
          const SizedBox(
            width: AppSpacing.md,
          ),
          Flexible(
            child: GradientText(
              'Secure Contact',
              gradientDirection:
              GradientDirection.ttb,
              style: const TextStyle(
                fontSize: AppSpacing.xll,
              ),
              colors: const [
                Colors.blue,
                Colors.cyanAccent,
              ],
            ),
          )
        ]);
  }


}