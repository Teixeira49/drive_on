import 'package:drive_on/src/core/utils/constants/app_constants.dart';
import 'package:drive_on/src/features/main_menu/data/entities/security_contacts.dart';
import 'package:drive_on/src/features/main_menu/data/entities/transaction.dart';
import 'package:drive_on/src/shared/presentation/widgets/floating_snack_bars.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/helpers/helpers.dart';

class ModalBottomSheetContact {
  static void show(BuildContext context, SecurityContacts contacts,
      VoidCallback deleteFunction) {
    showModalBottomSheet<void>(
        context: context,
        useSafeArea: true,
        builder: (context) {
          return Container(
              margin: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Informacion del contacto',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: const Text('Nombre'),
                        subtitle: Text(contacts.name),
                        trailing: const Icon(Icons.face),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: const Text('Telefono'),
                        subtitle: Text(contacts.phone),
                        trailing: const Icon(Icons.phone),
                      ),
                    ),
                    Visibility(
                      visible: contacts.relationship != null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: const Text('Vinculo personal'),
                          subtitle: Text(contacts.relationship ?? 'Ninguno'),
                          trailing: const Icon(Icons.family_restroom),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  FloatingSnackBar.show(
                                      context, 'Proximamente');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  //backgroundColor: Colors.blue, // <-- Button color
                                  foregroundColor: ColorPalette
                                      .shareContact, // <-- Splash color
                                ),
                                child: const Icon(Icons.share),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text('Compartir')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  print('editar');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  //backgroundColor: Colors.blue, // <-- Button color
                                  foregroundColor: ColorPalette
                                      .editContact, // <-- Splash color
                                ),
                                child: const Icon(Icons.edit),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text('Editar')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: deleteFunction,
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  //backgroundColor: Colors.blue, // <-- Button color
                                  foregroundColor: ColorPalette
                                      .deleteContact, // <-- Splash color
                                ),
                                child: const Icon(Icons.delete),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text('Eliminar')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ])));
        });
  }
}

class ModalBottomSheetTransaction {
  static void show(BuildContext context, Transaction transaction) {
    showModalBottomSheet<void>(
        context: context,
        useSafeArea: true,
        builder: (context) {
          return Container(
              margin: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Detalles de Transaccion',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        transaction.date,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text(
                        'Beneficiario',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        transaction.forT == youTarget
                            ? 'Usuario'
                            : transaction.forT,
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: const Icon(Icons.arrow_upward),
                    ),
                    ListTile(
                      title: const Text(
                        'Ordenante',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        transaction.byT == youTarget
                            ? 'Usuario'
                            : transaction.byT,
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: const Icon(Icons.arrow_downward),
                    ),
                    ListTile(
                      title: const Text(
                        'Saldo Transferido',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        Helper.fixMoney(transaction.operation),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: transaction.operation >= 0
                                ? ColorPalette.receiveMoney
                                : ColorPalette.sendMoney),
                      ),
                      trailing: const Icon(Icons.paid),
                    ),
                    const Divider(),
                  ])));
        });
  }
}

//showModalBottomSheet<void>(
//                           context: contextCubit,
//                           useSafeArea: true,
//                           builder: (contextCubit) {
//                             return Container(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                                 margin: const EdgeInsets.all(24),
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(bottom: 12),
//                                           child: Text(
//                                             'Agregar Contacto',
//                                             style: TextStyle(fontSize: 18),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 12),
//                                           child: TextFormField(
//                                             //controller: controller,
//                                             keyboardType: TextInputType.name,
//                                             decoration: const InputDecoration(
//                                                 suffixIcon: Icon(Icons.person),
//                                                 labelText: "Nombre completo"),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Por favor complete este campo';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 12),
//                                           child: TextFormField(
//                                             //controller: controller,
//                                             keyboardType: TextInputType.name,
//                                             decoration: const InputDecoration(
//                                                 suffixIcon: Icon(Icons.phone),
//                                                 labelText: "N° Telefono"),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Por favor complete este campo';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 12),
//                                           child: TextFormField(
//                                             //controller: controller,
//                                             keyboardType: TextInputType.name,
//                                             decoration: const InputDecoration(
//                                                 suffixIcon: Icon(Icons.people),
//                                                 labelText: "Relacion"),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Por favor complete este campo';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                       ]),
//                                 ));
//                           });
