import 'package:drive_on/src/core/config/styles/static_colors.dart';
import 'package:flutter/material.dart';

import '../../data/entities/popup_menu.dart';

class PopupMenu extends StatelessWidget {
  final int visibility;
  final int ref;
  final VoidCallback refreshFunction;

  const PopupMenu(
      {super.key,
      required this.visibility,
      required this.ref, required this.refreshFunction,});

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> budgetItems = [
      const PopupMenuItem(
          value: PopUpMenuItem.item2AddBudget,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.wallet,
                color: Colors.black54,
              ),
              SizedBox(
                width: 12,
              ),
              Text('Transaccion')
            ],
          ))
    ];

    List<PopupMenuItem> mainItems = [
      const PopupMenuItem(
          value: PopUpMenuItem.item1AddContact,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.person_add,
                color: Colors.black54,
              ),
              SizedBox(
                width: 12,
              ),
              Text('Agregar contacto')
            ],
          ))
    ];

    List<PopupMenuItem> profileItems = [
      const PopupMenuItem(
          value: PopUpMenuItem.item5edit,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.edit,
                color: Colors.black54,
              ),
              SizedBox(
                width: 12,
              ),
              Text('Editar Perfil')
            ],
          )),
      const PopupMenuItem(
          value: PopUpMenuItem.item5edit,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.upload,
                color: Colors.black54,
              ),
              SizedBox(
                width: 12,
              ),
              Text('Cambiar Plan')
            ],
          ))
    ];

    return PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        elevation: ColorPalette.elevationScaleS,
        onSelected: (value) {
          if (value == PopUpMenuItem.item1AddContact) {
            refreshFunction;
          } else if (value == PopUpMenuItem.item2AddBudget) {
          } else if (value == PopUpMenuItem.item3Config) {
          } else if (value == PopUpMenuItem.item4Logout) {
            Navigator.of(context).pop();
          }
        },
        itemBuilder: (contextCubit) => [
              if (visibility == ref && visibility != 0) ...mainItems,
              // Se puede hacer anidado
              if (visibility < ref) ...budgetItems,
              if (visibility > ref) ...profileItems,
              const PopupMenuItem(
                  value: PopUpMenuItem.item3Config,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.settings,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Configuracion')
                    ],
                  )),
              const PopupMenuItem(
                  value: PopUpMenuItem.item4Logout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Cerrar Sesion')
                    ],
                  )),
            ]);
  }
}
