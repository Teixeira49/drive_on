import 'package:drive_on/src/features/main_menu/presentation/widgets/budget/secure_card.dart';
import 'package:flutter/material.dart';

class HeaderBudgetMetrics extends StatelessWidget {
  final Widget body;
  final double assigned;
  final double used;
  final String lastUpdate;

  const HeaderBudgetMetrics(
      {super.key,
      this.assigned = 0.00,
      this.used = 0.00,
      this.lastUpdate = 'Searching', required this.body,
      });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(
              top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
          child: SecureCard(
              assigned: assigned, used: used, lastUpdate: lastUpdate)),
      Expanded(
          child: Container(
              width: double.infinity,
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
