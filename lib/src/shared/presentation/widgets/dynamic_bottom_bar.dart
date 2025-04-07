import 'package:drive_on/src/core/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DynamicNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String userType;

  const DynamicNavigationBar(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.userType});

  @override
  Widget build(BuildContext context) {
    var destination = <NavigationDestination>[
      const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Inicio',
      tooltip: 'Contactos de emergencia',),
      const NavigationDestination(
        icon: Icon(Icons.person_outlined),
        selectedIcon: Icon(Icons.person),
        label: 'Perfil',
        tooltip: 'Informacion del usuario',
      ),
    ];

    if (userType == typeCorporate) {
      destination = [
        const NavigationDestination(
          icon: Icon(Icons.wallet_outlined),
          selectedIcon: Icon(Icons.wallet),
          label: 'Presupuesto',
          tooltip: 'Uso del saldo asignado por el Departamento',
        ),
        ...destination
      ];
    }

    return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        destinations: destination);
  }
}
