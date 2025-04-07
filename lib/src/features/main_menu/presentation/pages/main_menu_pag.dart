import 'package:drive_on/src/features/main_menu/data/datasource/remote/main_menu_datasource_abst.dart';
import 'package:drive_on/src/features/main_menu/data/repository/main_menu_repository_impl.dart';
import 'package:drive_on/src/features/main_menu/domain/repository/main_menu_repository_abst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../shared/presentation/cubit/user_cubit/user_cubit.dart';
import '../../../../shared/presentation/widgets/custom_progress_indicator.dart';
import '../../../../shared/presentation/widgets/dynamic_bottom_bar.dart';
import '../../../../shared/presentation/widgets/floating_snack_bars.dart';
import '../../data/datasource/remote/main_menu_datasource_impl.dart';
import '../../domain/use_cases/get_contacts_usecase.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../cubit/contacts_cubit/contacts_cubit.dart';
import '../cubit/contacts_cubit/contacts_state.dart';
import '../cubit/profile_cubit/profile_cubit.dart';
import '../cubit/profile_cubit/profile_state.dart';
import '../widgets/contact_tile.dart';
import '../widgets/gradient_floating_action_button.dart';
import '../widgets/popup_menu.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenuPage> {
  int _currentPageIndex = 1;
  int _viewFABIndex = 1;
  bool _isInit = true;

  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final argument = ModalRoute.of(context)!.settings.arguments as Map;
      if (argument['userIndex'] != null) {
        _currentPageIndex = argument['userIndex'];
        _viewFABIndex = _currentPageIndex;
      }
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _changeView(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final MainMenuRemoteDatasource mainMenuRemoteDatasource =
        MainMenuRemoteDatasourceImpl();
    final MainMenuRepository mainMenuRepository =
        MainMenuRepositoryImpl(mainMenuRemoteDatasource);
    final GetContactsUseCase getContactsUseCase =
        GetContactsUseCase(mainMenuRepository);
    final GetProfileUseCase getProfileUseCase =
        GetProfileUseCase(mainMenuRepository);

    final int id = context.read<UserCubit>().getUser() != null
        ? context.read<UserCubit>().getUser()!.userId
        : -1; // Change

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => ProfileCubit(getProfileUseCase)..getProfile(id)),
          BlocProvider(
            create: (_) =>
                ContactsCubit(getContactsUseCase)..getMyAllocatedContacts(id),
          ),
        ],
        child: BlocBuilder<ContactsCubit, ContactsState>(
            builder: (contextCubit, stateCubit) {
          return BlocBuilder<ProfileCubit, ProfileState>(
              builder: (contextCubitProfile, stateCubitProfile) {
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
                        [
                          if (context.read<UserCubit>().getUser()?.userType == typeCorporate) ' Presupuesto',
                          ' Hola, ${context.read<UserCubit>().getUser()?.userName ?? 'Usuario'}',
                          ' Perfil'
                        ][_currentPageIndex],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      actions: [
                        PopupMenu(
                          visibility: _currentPageIndex,
                          ref: _viewFABIndex,
                        )
                      ],
                    ),
                    body: [
                      if (context.read<UserCubit>().getUser()?.userType == typeCorporate) Container(),
                      _contactList(stateCubit, contextCubit, id),
                      _profileBody(stateCubitProfile, contextCubitProfile, id),
                    ][_currentPageIndex],
                    floatingActionButton: Visibility(
                        visible: _viewFABIndex == _currentPageIndex,
                        child: const GradientFloatingActionButton()),
                    bottomNavigationBar: DynamicNavigationBar(
                      currentIndex: _currentPageIndex,
                      onTap: _changeView,
                      userType: context.read<UserCubit>().getUser()?.userType ??
                          typePersonal,
                    )));
          });
        }));
  }

  Widget _contactList(ContactsState state, BuildContext context, int id) {
    if (state is ContactsStateInitial || state is ContactsStateLoading) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.only(
                top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'Buscando casos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              tileColor: Colors.greenAccent.withOpacity(0.3),
            )),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomCircularProgressBar()],
          ),
        ))
      ]);
    } else if (state is ContactsStateLoadedButEmpty) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.only(
                top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'N° Contactos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: const Text(
                '0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              tileColor: Colors.greenAccent.withOpacity(0.3),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.error,
                size: 48,
              ),
              Text(state.message),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8)),
                  onPressed: () {
                    context.read<ContactsCubit>().getMyAllocatedContacts(1);
                  },
                  child: const Text('Reintentar'))
            ],
          ),
        ))
      ]);
    } else if (state is ContactsStateLoaded) {
      final filteredContacts = state.securityContacts;
      //.where((element) => element.name.toLowerCase().contains(state));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: const Text(
                  'N° Contactos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                trailing: Text(
                  '${filteredContacts.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                tileColor: Colors.greenAccent.withOpacity(0.3),
              )),
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<ContactsCubit>().getMyAllocatedContacts(id);
                    },
                    child: Scrollbar(
                        controller: _scrollController,
                        radius: const Radius.circular(45),
                        child: ListView.builder(
                            //padding: ,
                            controller: _scrollController,
                            itemCount: filteredContacts.length,
                            itemBuilder: (context, index) {
                              if (index >= state.securityContacts.length) {
                                return const Center(
                                    child: CustomCircularProgressBar());
                              }
                              return ContactTile(
                                securityContacts: filteredContacts[index],
                              );
                            })),
                  ),
                ),
          )
        ],
      );
    } else if (state is ContactsStateErrorLoading) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.only(
                top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'N° Contactos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: const Text(
                '# - Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              tileColor: Colors.greenAccent.withOpacity(0.3),
            )),
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.error,
                size: 48,
              ),
              Text(state.message),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8)),
                  onPressed: () {
                    context.read<ContactsCubit>().getMyAllocatedContacts(1);
                  },
                  child: const Text('Reintentar'))
            ],
          ),
        ))
      ]);
    } else if (state is ContactsStateError) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.only(
                top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'N° Contactos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: const Text(
                '# - Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              tileColor: Colors.greenAccent.withOpacity(0.3),
            )),
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.error,
                size: 48,
              ),
              Text(state.message),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8)),
                  onPressed: () {
                    context.read<ContactsCubit>().getMyAllocatedContacts(1);
                  },
                  child: const Text('Reintentar'))
            ],
          ),
        ))
      ]);
    } else if (state is ContactsStateCatchError) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.only(
                top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'N° Contactos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: const Text(
                '# - Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              tileColor: Colors.greenAccent.withOpacity(0.3),
            )),
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.error,
                size: 48,
              ),
              Text(state.message),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8)),
                  onPressed: () {
                    context.read<ContactsCubit>().getMyAllocatedContacts(1);
                  },
                  child: const Text('Reintentar'))
            ],
          ),
        ))
      ]);
    } else {
      return Container();
    }
  }

  Widget _profileBody(ProfileState state, BuildContext context, int id) {
    if (state is ProfileStateInitial || state is ProfileStateLoading) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
        ),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCircularProgressBar(),
              SizedBox(
                height: 12,
              ),
              Text('Buscando Perfil'),
            ],
          ),
        ))
      ]);
    } else if (state is ProfileStateLoaded) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
        ),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileCubit>().getProfile(id);
              },
              child: SingleChildScrollView(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: const CircleAvatar(
                      radius: 45.0,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.account_circle,
                        size: 84,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      state.user.userName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text(
                            'Correo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            state.user.userEmail,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                          height: 12,
                        ),
                        ListTile(
                          leading: const Icon(Icons.wallet),
                          title: const Text(
                            'Plan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            Helper.capitalize(state.user.userType),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Visibility(
                          visible: state.user.userType == typeCorporate,
                          child: const Divider(
                            indent: 16,
                            endIndent: 16,
                            height: 12,
                          ),
                        ),
                        Visibility(
                          visible: state.user.userType == typeCorporate,
                          child: ListTile(
                            leading: const Icon(Icons.factory),
                            title: const Text(
                              'Departamento',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              Helper.upper(
                                  state.user.userDepartment ?? ''),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                          height: 12,
                        ),
                        ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: const Text(
                            'Id Usuario',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            '${state.user.userId}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          title: const Text(
                            'Editar Perfil',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: const Icon(Icons.edit),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () {
                            Future.delayed(const Duration(seconds: 100), () {
                              FloatingSnackBar.show(context, "Proximamente");
                            });
                          },
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                          height: 12,
                        ),
                        ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            title: const Text(
                              'Cambiar plan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(Icons.file_upload),
                            trailing: const Icon(Icons.navigate_next),
                            onTap: () {
                              Future.delayed(const Duration(seconds: 100), () {
                                FloatingSnackBar.show(context, "Proximamente");
                              });
                            }),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                          height: 12,
                        ),
                        ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            title: const Text(
                              'Cerrar Sesion',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(Icons.logout),
                            trailing: const Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  ),
                ],
              ))),
        ))
      ]);
    } else {
      return Container();
    }
  }
}
