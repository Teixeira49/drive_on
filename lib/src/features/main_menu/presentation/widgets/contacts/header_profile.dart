
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderName extends StatelessWidget {
  final String name;
  const HeaderName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

}

class HeaderImg extends StatelessWidget {
  const HeaderImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: const CircleAvatar(
        radius: 45.0,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.account_circle,
          size: 84,
        ),
      ),
    );
  }

}