
import 'package:flutter/material.dart';

class DynamicBottomBar extends BottomNavigationBar {
  DynamicBottomBar({super.key, required super.items});

  @override
  // TODO: implement items
  List<BottomNavigationBarItem> get items => const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
}