import 'package:flutter/material.dart';

import '../../../core/config/styles/static_colors.dart';

class CustomCircularProgressBar extends StatelessWidget {

  const CustomCircularProgressBar({super.key, this.labelText});

  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child:  CircularProgressIndicator(
        strokeWidth: 5.5,
        strokeAlign: BorderSide.strokeAlignInside,
        semanticsLabel: labelText,
      ),
    );
  }

}