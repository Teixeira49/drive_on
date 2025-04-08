import 'package:flutter/material.dart';

class HeaderProfileMetrics extends StatelessWidget {
  const HeaderProfileMetrics({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
      ),
      Expanded(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: body))
    ]);
  }
}
