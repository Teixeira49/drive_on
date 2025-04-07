import 'package:drive_on/src/features/main_menu/data/datasource/remote/main_menu_datasource_abst.dart';
import 'package:drive_on/src/features/main_menu/data/repository/main_menu_repository_impl.dart';
import 'package:drive_on/src/features/main_menu/domain/repository/main_menu_repository_abst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../shared/presentation/cubit/user_cubit/user_cubit.dart';
import '../../../../shared/presentation/widgets/custom_progress_indicator.dart';
import '../../../../shared/presentation/widgets/dynamic_bottom_bar.dart';
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
                      actions: [PopupMenu(visibility: _currentPageIndex, ref: _viewFABIndex)],
                    ),
                    body: [
                      RefreshIndicator(
                          onRefresh: () async {
                            print('e');
                          },
                          child: _contactList(stateCubit, contextCubit)),
                      RefreshIndicator(
                          onRefresh: () async {
                            print('e');
                          },
                          child: _profileBody(
                              stateCubitProfile, contextCubitProfile))
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

  Widget _contactList(ContactsState state, BuildContext context) {
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
                child: GestureDetector(
                  onVerticalDragDown: (DragDownDetails details) {
                    if (details.globalPosition.dy < 50) {}
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
                        }),
                  ),
                )),
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

  Widget _profileBody(ProfileState state, BuildContext context) {
    if (state is ProfileStateInitial || state is ProfileStateLoading) {
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: const Text('Correo'),
                        subtitle: Text(state.user.userEmail),
                      ),
                      ListTile(
                        title: const Text('Plan'),
                        subtitle: Text(state.user.userType),
                      ),
                      Visibility(
                        visible: state.user.userType == typeCorporate,
                        child: ListTile(
                          title: const Text('Departamento'),
                          subtitle: Text('${state.user.userId}'),
                        ),
                      ),
                      ListTile(
                        title: const Text('Id Usuario'),
                        subtitle: Text('${state.user.userId}'),
                      ),
                      Divider(),
                    ],
                  ),
                )))
      ]);
    } else {
      return Container();
    }
  }
}
