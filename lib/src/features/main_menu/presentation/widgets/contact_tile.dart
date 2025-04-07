import 'package:drive_on/src/features/main_menu/data/entities/security_contacts.dart';
import 'package:flutter/material.dart';

import 'modal_bottom_sheet.dart';

class ContactTile extends StatelessWidget {
  final SecurityContacts securityContacts;
  const ContactTile({super.key, required this.securityContacts});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 3,),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
          title: Text(securityContacts.name),
          subtitle: Wrap(children: [
            //const Icon(Icons.phone),
            Text('Telefono: ${securityContacts.phone}'),
            //Divider(),
          ]),
          leading: const Icon(Icons.account_circle),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            ModalBottomSheet.show(context, securityContacts);
          },
        ),
        const Divider(height: 3, indent: 12, endIndent: 12,)
      ],
    ));
  }
}
