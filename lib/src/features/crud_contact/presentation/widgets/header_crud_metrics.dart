import 'package:flutter/material.dart';

class HeaderCRUDMetrics extends StatelessWidget {
  const HeaderCRUDMetrics({super.key, required this.body});

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
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topCenter,
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