import 'package:flutter/material.dart';

import 'contacts_label.dart';

class HeaderContactMetrics extends StatelessWidget {
  final String contactsNum;
  final Widget body;

  const HeaderContactMetrics(
      {super.key, required this.contactsNum, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(
              top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
          child: ContactsLabel(
            contactsNum: contactsNum,
          )),
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
