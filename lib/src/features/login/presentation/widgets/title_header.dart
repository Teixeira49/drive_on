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
          const Icon(
            Icons.add_box,
            size: AppSpacing.xl,
          ),
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