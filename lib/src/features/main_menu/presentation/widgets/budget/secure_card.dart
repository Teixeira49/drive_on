import 'package:flutter/material.dart';

import '../../../../../core/helpers/helpers.dart';
import '../../../../../core/utils/constants/error_constants.dart';

class SecureCard extends StatelessWidget {
  final double assigned;
  final double used;
  final String lastUpdate;

  const SecureCard(
      {super.key,
      required this.assigned,
      required this.used,
      required this.lastUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent.withOpacity(0.3),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              ListTile(
                  leading: const SizedBox(),
                  minLeadingWidth: 0,
                  title: const Text(
                    'Saldo Actual:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    lastUpdate != undefinedCard
                        ? Helper.fixMoney(assigned)
                        : undefinedAmount,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                    size: 32,
                  ) // Change for a Asset
                  ),
              const Divider(
                height: 0,
                endIndent: 16,
                indent: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 32,
                  ),
                  const Text(
                    'Utilizado',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                      lastUpdate != undefinedCard
                          ? Helper.fixMoney(used * -1)
                          : undefinedAmount,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 32,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 32,
                  ),
                  const Text(
                    'Ultima Transaccion',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(lastUpdate,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 32,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
