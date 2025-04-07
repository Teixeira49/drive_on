import 'package:flutter/material.dart';

class DynamicNavigationBar extends NavigationBar {
  DynamicNavigationBar(
      {super.key, required super.destinations});

  @override
  // TODO: implement items
  List<NavigationDestination> get destinations => const <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.wallet_outlined),
      selectedIcon: Icon(Icons.wallet),
      label: 'Presupuesto',
    ),
    NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Inicio'),
    NavigationDestination(
      icon: Icon(Icons.person_outlined),
      selectedIcon: Icon(Icons.person),
      label: 'Perfil',
      tooltip: 'pepe',
    ),
      ];
}
