import 'package:drive_on/src/features/crud_contact/data/datasource/remote/crud_contacts_datasource_abstract.dart';
import 'package:drive_on/src/features/crud_contact/data/datasource/remote/crud_contacts_datasource_impl.dart';
import 'package:drive_on/src/shared/data/entities/security_contacts.dart';
import 'package:drive_on/src/shared/presentation/widgets/floating_snack_bars.dart';
import 'package:drive_on/src/shared/presentation/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/margin.dart';
import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../shared/presentation/formatter/phone_formatter.dart';
import '../../../main_menu/presentation/widgets/popup_menu.dart';
import '../../data/repository/crud_contacts_repository_impl.dart';
import '../../domain/repository/crud_contacts_repository_abstract.dart';
import '../../domain/use_cases/add_contact_use_case.dart';
import '../../domain/use_cases/update_contact_use_case.dart';
import '../cubit/crud_cubit/crud_cubit.dart';
import '../cubit/crud_cubit/crud_state.dart';
import '../widgets/header_crud_metrics.dart';

class CRUDContactPage extends StatefulWidget {
  const CRUDContactPage({super.key});

  @override
  CRUDContactState createState() => CRUDContactState();
}

class CRUDContactState extends State<CRUDContactPage> {
  bool _isInit = true;
  int _index = -1;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<String?> _relationshipController =
      ValueNotifier<String?>(null);

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final argument = ModalRoute.of(context)!.settings.arguments as Map;
      if (argument['op'] == updateTarget) {
        _index = argument['index'];
        _nameController.text = argument['contacts'][_index].name;
        _phoneController.text = argument['contacts'][_index].phone;
        _relationshipController.value =
            argument['contacts'][_index].relationship;
      }
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    final int id = argument['id'];
    final String op = argument['op'];
    final List<SecurityContacts> contacts =
        argument['contacts'].isNotEmpty ? argument['contacts'] : [];

    final ContactsRemoteDatasource datasource = ContactsRemoteDatasourceImpl();
    final CRUDContactsRepository contactsRepository =
        CRUDContactsRepositoryImpl(datasource);
    final AddContactUseCase addContactUseCase =
        AddContactUseCase(contactsRepository);
    final UpdateContactUseCase updateContactUseCase =
        UpdateContactUseCase(contactsRepository);
    return BlocProvider(
        create: (_) => CRUDCubit(addContactUseCase, updateContactUseCase),
        child: BlocConsumer<CRUDCubit, CRUDState>(
            listener: (BuildContext context, CRUDState state) {
          if (state is CRUDStateLoading) {
            LoadingShowDialog.show(context, state.message);
          } else if (state is CRUDStatePosted) {
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(true);
            Future.delayed(const Duration(milliseconds: 100), () {
              FloatingSnackBar.show(context, state.message);
            });
          } else if (state is CRUDStateError ||
              state is CRUDStateCatchError ||
              state is CRUDStateTimeout) {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 100), () {
              FloatingSnackBar.show(context, _errorCRUD(state));
            });
          } else {
            Navigator.pop(context);
          }
        }, builder: (BuildContext context, CRUDState state) {
          return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: ColorPalette.mainGradient)),
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      op == updateTarget
                          ? "Actualizar contacto"
                          : "Añadir contacto",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actions: [
                      PopupMenu(
                        visibility: 0,
                        ref: 0,
                        refreshFunction: () {},
                      )
                    ],
                  ),
                  body: HeaderCRUDMetrics(
                      body: SafeArea(
                    minimum: const EdgeInsets.all(AppSpacing.lg),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_add,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  'Informacion del Contacto',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: TextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.face),
                                    labelText: "Nombre completo"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor complete este campo';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  PhoneNumberFormatter(),
                                ],
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.phone),
                                    labelText: "N° Telefono"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor complete este campo';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: DropdownButtonFormField(
                                value: _relationshipController.value,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.family_restroom),
                                    labelText: "Relacion"),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por favor complete este campo';
                                  }
                                  return null;
                                },
                                items: relationship.map((item) {
                                  return DropdownMenuItem(
                                      value: item,
                                      alignment: Alignment.centerLeft,
                                      child: Text(item));
                                }).toList(),
                                onChanged: (newValue) {
                                  _relationshipController.value = newValue;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: ColorPalette.elevationScaleS,
                                  backgroundColor: Colors.lightBlueAccent,
                                  shadowColor: Colors.cyanAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8)),
                              onPressed: () {
                                if (op == updateTarget) {
                                  context.read<CRUDCubit>().updateContact(
                                      contacts,
                                      Helper.capitalize(_nameController.text),
                                      _phoneController.text,
                                      _relationshipController.value,
                                      id,
                                      _index);
                                } else {
                                  context.read<CRUDCubit>().addContact(
                                      contacts,
                                      Helper.capitalize(_nameController.text),
                                      _phoneController.text,
                                      _relationshipController.value,
                                      id);
                                }
                              },
                              child: const Text('Guardar',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))));
        }));
  }

  String _errorCRUD(CRUDState state) {
    if (state is CRUDStateTimeout) {
      return state.message;
    } else if (state is CRUDStateTimeout) {
      return state.message;
    } else if (state is CRUDStateTimeout) {
      return state.message;
    } else {
      return 'Error de Aplicacion';
    }
  }
}
