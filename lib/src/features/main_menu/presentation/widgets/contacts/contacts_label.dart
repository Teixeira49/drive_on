import 'package:drive_on/src/core/config/styles/static_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/app_constants.dart';

class ContactsLabel extends StatelessWidget {
  final String contactsNum;

  const ContactsLabel({super.key, required this.contactsNum});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        contactsNum == emptyString ? "Buscando casos" : 'N° Contactos',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: Text(
        contactsNum,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      tileColor: ColorPalette.contactsCard,
    );
  }
}
