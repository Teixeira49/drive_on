
import 'package:drive_on/src/core/config/styles/static_colors.dart';
import 'package:flutter/material.dart';

import '../../data/entities/popup_menu.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      elevation: ColorPalette.elevationScaleS,
        onSelected: (value) {
          if (value == PopUpMenuItem.item1AddContact) {
            print('a');
          } else if (value == PopUpMenuItem.item2Config) {

          } else if (value == PopUpMenuItem.item3Logout) {
            Navigator.of(context).pop();
          }
        },
        itemBuilder: (contextCubit) => [
          const PopupMenuItem(
              value: PopUpMenuItem.item1AddContact,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 6,),
                  Icon(Icons.person_add, color: Colors.black54,),
                  SizedBox(width: 12,),
                  Text('Agregar contacto')
                ],
              )
          ),
          const PopupMenuItem(
              value: PopUpMenuItem.item2Config,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 6,),
                  Icon(Icons.settings, color: Colors.black54,),
                  SizedBox(width: 12,),
                  Text('Configuracion')
                ],
              )
          ),
          const PopupMenuItem(
              value: PopUpMenuItem.item3Logout,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 6,),
                  Icon(Icons.logout, color: Colors.black54,),
                  SizedBox(width: 12,),
                  Text('Cerrar Sesion')
                ],
              )
          ),
        ]
    );
  }


}