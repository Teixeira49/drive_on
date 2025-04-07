import 'package:drive_on/src/features/main_menu/data/datasource/remote/main_menu_datasource_abst.dart';
import 'package:drive_on/src/features/main_menu/data/repository/main_menu_repository_impl.dart';
import 'package:drive_on/src/features/main_menu/domain/repository/main_menu_repository_abst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../shared/presentation/cubit/user_cubit/user_cubit.dart';
import '../../../../shared/presentation/widgets/custom_progress_indicator.dart';
import '../../data/datasource/remote/main_menu_datasource_impl.dart';
import '../../domain/use_cases/get_contacts_usecase.dart';
import '../cubit/contacts_cubit/contacts_cubit.dart';
import '../cubit/contacts_cubit/contacts_state.dart';
import '../widgets/modal_bottom_sheet.dart';
import '../widgets/popup_menu.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenuPage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

    final int id = context.read<UserCubit>().getUser() != null
        ? context.read<UserCubit>().getUser()!.userId
        : -1;

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                ContactsCubit(getContactsUseCase)..getMyAllocatedContacts(id),
          )
        ],
        child: BlocBuilder<ContactsCubit, ContactsState>(
            builder: (contextCubit, stateCubit) {
          return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: ColorPalette.mainGradient)),
              child: Scaffold(
                appBar: AppBar(
                  title:  Text(
                      ' Hola, ${context.read<UserCubit>().getUser()?.userName ?? 'Usuario'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),),
                  automaticallyImplyLeading: false,
                  actions: const [PopupMenu()],
                ),
                body: _contactList(stateCubit, contextCubit),
                floatingActionButton: FloatingActionButton(
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                  onPressed: () {},
                  elevation: ColorPalette.elevationScaleNone,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blueGrey,
                            offset: Offset(0, 2.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: ColorPalette.mainGradient)),
                    child: const Icon(Icons.add),
                  ),
                ),
                bottomNavigationBar: NavigationBar(
                  labelBehavior: labelBehavior,
                  selectedIndex: currentPageIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(Icons.wallet_outlined),
                      selectedIcon: Icon(Icons.wallet),
                      label: 'Presupuesto',
                    ),
                    const NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Inicio'),
                    const NavigationDestination(
                      icon: Icon(Icons.person_outlined),
                      selectedIcon: Icon(Icons.person),
                      label: 'Perfil',
                      tooltip: 'pepe',
                    ),
                  ],
                ),
              ));
        }));
  }

  Widget _contactList(ContactsState state, BuildContext context) {
    if (state is ContactsStateInitial || state is ContactsStateLoading) {
      return const Center(
        child: CustomCircularProgressBar(),
      );
    } else if (state is ContactsStateLoadedButEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: SafeArea(
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
          ),
        ),
      );
    } else if (state is ContactsStateLoaded) {
      final filteredContacts = state.securityContacts;
      //.where((element) => element.name.toLowerCase().contains(state));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 12.0, left: 14.0, right: 14.0, bottom: 22.0),
            child:
                ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              title: const Text('N° Contactos', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),),
              trailing: Text('${filteredContacts.length}', style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),),
              tileColor: Colors.greenAccent.withOpacity(0.3),
            )
          ),
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
                        return const Center(child: CustomCircularProgressBar());
                      }
                      return ListTile(
                        title: Text(filteredContacts[index].name),
                        subtitle: Wrap(children: [
                          //const Icon(Icons.phone),
                          Text('Telefono: ${filteredContacts[index].phone}'),
                          //Divider(),
                        ]),
                        leading: const Icon(Icons.account_circle),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          ModalBottomSheet.show(
                              context, filteredContacts[index]);
                        },
                      );
                    }),
              ),
            ),
          ))
        ],
      );
    } else if (state is ContactsStateErrorLoading) {
      return Center(
        child: SingleChildScrollView(
          child: SafeArea(
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
          ),
        ),
      );
    } else if (state is ContactsStateError) {
      return Center(
        child: SingleChildScrollView(
          child: SafeArea(
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
          ),
        ),
      );
    } else if (state is ContactsStateCatchError) {
      return Center(
        child: SingleChildScrollView(
          child: SafeArea(
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
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
