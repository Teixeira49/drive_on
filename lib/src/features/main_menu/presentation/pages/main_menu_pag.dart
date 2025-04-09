import 'package:drive_on/src/features/main_menu/data/datasource/remote/main_menu_datasource_abst.dart';
import 'package:drive_on/src/features/main_menu/data/repository/main_menu_repository_impl.dart';
import 'package:drive_on/src/features/main_menu/domain/repository/main_menu_repository_abst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/constants/error_constants.dart';
import '../../../../shared/presentation/cubit/user_cubit/user_cubit.dart';
import '../../../../shared/presentation/widgets/custom_progress_indicator.dart';
import '../../../../shared/presentation/widgets/dynamic_bottom_bar.dart';
import '../../../../shared/presentation/widgets/floating_snack_bars.dart';
import '../../data/datasource/remote/main_menu_datasource_impl.dart';
import '../../domain/use_cases/budget/get_budget_use_case.dart';
import '../../domain/use_cases/contacts/delete_contacts_use_case.dart';
import '../../domain/use_cases/contacts/get_contacts_use_case.dart';
import '../../domain/use_cases/profile/get_profile_use_case.dart';
import '../cubit/budget_cubit/budget_cubit.dart';
import '../cubit/budget_cubit/budget_state.dart';
import '../cubit/contacts_cubit/contacts_cubit.dart';
import '../cubit/contacts_cubit/contacts_state.dart';
import '../cubit/profile_cubit/profile_cubit.dart';
import '../cubit/profile_cubit/profile_state.dart';
import '../widgets/budget/budget_tile.dart';
import '../widgets/budget/header_budget_metrics.dart';
import '../widgets/contacts/contact_tile.dart';
import '../widgets/contacts/header_contacts_metrics.dart';
import '../widgets/profile/header_profile.dart';
import '../widgets/gradient_floating_action_button.dart';
import '../widgets/popup_menu.dart';
import '../widgets/profile/header_profile_metrics.dart';
import '../widgets/profile/profile_tile.dart';

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
    final MainMenuRemoteDatasource mainMenuRemoteDatasource =
        MainMenuRemoteDatasourceImpl();
    final MainMenuRepository mainMenuRepository =
        MainMenuRepositoryImpl(mainMenuRemoteDatasource);
    final GetContactsUseCase getContactsUseCase =
        GetContactsUseCase(mainMenuRepository);
    final DeleteContactsUseCase deleteContactsUseCase =
        DeleteContactsUseCase(mainMenuRepository);
    final GetProfileUseCase getProfileUseCase =
        GetProfileUseCase(mainMenuRepository);
    final GetBudgetUseCase getBudgetUseCase =
        GetBudgetUseCase(mainMenuRepository);

    final int id = context.read<UserCubit>().getUser() != null
        ? context.read<UserCubit>().getUser()!.userId
        : -1; // Change

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => ProfileCubit(getProfileUseCase)..getProfile(id)),
          BlocProvider(
              create: (_) =>
                  ContactsCubit(getContactsUseCase, deleteContactsUseCase)
                    ..getMyAllocatedContacts(id)),
          BlocProvider(
            create: (_) =>
                BudgetCubit(getBudgetUseCase)..getWalletAndHistory(id),
          ),
        ],
        child: BlocBuilder<ContactsCubit, ContactsState>(
            builder: (contextCubit, stateCubit) {
          return BlocBuilder<ProfileCubit, ProfileState>(
              builder: (contextCubitProfile, stateCubitProfile) {
            return BlocBuilder<BudgetCubit, BudgetState>(
                builder: (contextCubitBudget, stateCubitBudget) {
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
                            if (context.read<UserCubit>().getUser()?.userType ==
                                typeCorporate)
                              ' Presupuesto',
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
                            refreshFunction: () async {
                              final result =
                                  await Navigator.of(context).pushNamed(
                                '/main/contacts-wallet/new-contact',
                                arguments: {
                                  'id': id,
                                  'contacts': stateCubit is ContactsStateLoaded
                                      ? stateCubit.securityContacts
                                      : [],
                                  'op': 'add'
                                },
                              );
                              if (result == true) {
                                contextCubit
                                    .read<ContactsCubit>()
                                    .getMyAllocatedContacts(id);
                              }
                            },
                          )
                        ],
                      ),
                      body: [
                        if (context.read<UserCubit>().getUser()?.userType ==
                            typeCorporate)
                          _walletBody(stateCubitBudget, contextCubitBudget, id),
                        _contactList(stateCubit, contextCubit, id),
                        _profileBody(
                            stateCubitProfile, contextCubitProfile, id),
                      ][_currentPageIndex],
                      floatingActionButton: Visibility(
                          visible: _viewFABIndex == _currentPageIndex &&
                              _checkState(stateCubit),
                          child: GradientFloatingActionButton(
                            refreshContacts: () async {
                              final result = await Navigator.of(context).pushNamed(
                                '/main/contacts-wallet/new-contact',
                                arguments: {
                                  'id': id,
                                  'contacts': stateCubit is ContactsStateLoaded
                                      ? stateCubit.securityContacts
                                      : [],
                                  'op': 'add'
                                },
                              );
                              if (result == true) {
                                contextCubit
                                    .read<ContactsCubit>()
                                    .getMyAllocatedContacts(id);
                              }
                            },
                          )),
                      bottomNavigationBar: DynamicNavigationBar(
                        currentIndex: _currentPageIndex,
                        onTap: _changeView,
                        userType:
                            context.read<UserCubit>().getUser()?.userType ??
                                typePersonal,
                      )));
            });
          });
        }));
  }

  Widget _contactList(ContactsState state, BuildContext context, int id) {
    if (state is ContactsStateInitial || state is ContactsStateLoading) {
      return const HeaderContactMetrics(
        contactsNum: emptyString,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircularProgressBar(),
            SizedBox(
              height: 12,
            ),
            Text(
              'Descargando informacion',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else if (state is ContactsStateLoadedButEmpty) {
      return HeaderContactMetrics(
        contactsNum: '0',
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 128,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorPalette.alertGradient)
                  .createShader(bounds),
              child: const Icon(
                Icons.error,
                size: 72,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              state.message,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 102,
            ),
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
                  context.read<ContactsCubit>().getMyAllocatedContacts(id);
                },
                child: const Text('Reintentar',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          ],
        ),
      );
    } else if (state is ContactsStateLoaded) {
      final filteredContacts = state
          .securityContacts; //.where((element) => element.name.toLowerCase().contains(state));
      return HeaderContactMetrics(
        contactsNum: '${filteredContacts.length}',
        body: RefreshIndicator(
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
                      return const Center(child: CustomCircularProgressBar());
                    }
                    return ContactTile(
                      securityContacts: filteredContacts[index],
                      deleteFunction: () {
                        context
                            .read<ContactsCubit>()
                            .deleteContact(filteredContacts, index, id);
                        Navigator.of(context).pop();
                      },
                    );
                  })),
        ),
      );
    } else if (state is ContactsStateErrorLoading ||
        state is ContactsStateError ||
        state is ContactsStateCatchError) {
      return HeaderContactMetrics(
        contactsNum: undefinedAmount,
        body: Column(
          children: [
            const SizedBox(
              height: 128,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorPalette.alertGradient)
                  .createShader(bounds),
              child: const Icon(
                Icons.error,
                size: 72,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              _errorContactMessage(state),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 102,
            ),
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
                  context.read<ContactsCubit>().getMyAllocatedContacts(id);
                },
                child: const Text('Reintentar',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  bool _checkState(ContactsState state) {
    if (state is ContactsStateLoaded || state is ContactsStateLoadedButEmpty) {
      return true;
    }
    return false;
  }

  String _errorContactMessage(ContactsState state) {
    if (state is ContactsStateErrorLoading) {
      return state.message;
    } else if (state is ContactsStateError) {
      return state.message;
    } else if (state is ContactsStateCatchError) {
      return state.message;
    } else {
      return 'Error en aplicacion';
    }
  }

  Widget _profileBody(ProfileState state, BuildContext context, int id) {
    if (state is ProfileStateInitial || state is ProfileStateLoading) {
      return const HeaderProfileMetrics(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircularProgressBar(),
            SizedBox(
              height: 12,
            ),
            Text(
              'Buscando Perfil',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else if (state is ProfileStateLoaded) {
      return HeaderProfileMetrics(
        body: RefreshIndicator(
            onRefresh: () async {
              context.read<ProfileCubit>().getProfile(id);
            },
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const HeaderImg(),
                HeaderName(name: state.user.userName),
                const SizedBox(
                  height: 6,
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      ProfileTile(
                        userRow: state.user.userEmail,
                        keyRow: 'Correo',
                        iconData: Icons.email,
                      ),
                      const TileDivisor(),
                      ProfileTile(
                        userRow: state.user.userType,
                        keyRow: 'Plan',
                        iconData: Icons.wallet,
                      ),
                      Visibility(
                        visible: state.user.userType == typeCorporate,
                        child: const TileDivisor(),
                      ),
                      Visibility(
                        visible: state.user.userType == typeCorporate,
                        child: ProfileTile(
                          userRow:
                              Helper.upper(state.user.userDepartment ?? ''),
                          keyRow: 'Departamento',
                          iconData: Icons.factory,
                        ),
                      ),
                      const TileDivisor(),
                      ProfileTile(
                        userRow: '${state.user.userId}',
                        keyRow: 'Id Usuario',
                        iconData: Icons.verified_user,
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
                      ProfileTileButton(
                          keyRow: 'Editar Perfil',
                          iconData: Icons.edit,
                          function: () {
                            Future.delayed(const Duration(seconds: 100), () {
                              FloatingSnackBar.show(context, "Proximamente");
                            });
                          }),
                      const TileDivisor(),
                      ProfileTileButton(
                          keyRow: 'Cambiar plan',
                          iconData: Icons.file_upload,
                          function: () {
                            Future.delayed(const Duration(seconds: 100), () {
                              FloatingSnackBar.show(context, "Proximamente");
                            });
                          }),
                      const TileDivisor(),
                      ProfileTileButton(
                          keyRow: 'Cerrar Sesion',
                          iconData: Icons.logout,
                          function: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
              ],
            ))),
      );
    } else if (state is ProfileStateTimeout ||
        state is ProfileStateError ||
        state is ProfileStateCatchError) {
      return HeaderProfileMetrics(
        body: Column(
          children: [
            const SizedBox(
              height: 128,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorPalette.alertGradient)
                  .createShader(bounds),
              child: const Icon(
                Icons.error,
                size: 72,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              _errorProfileMessage(state),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 102,
            ),
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
                  context.read<ProfileCubit>().getProfile(id);
                },
                child: const Text('Reintentar',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  String _errorProfileMessage(ProfileState state) {
    if (state is ProfileStateTimeout) {
      return state.sms;
    } else if (state is ProfileStateError) {
      return state.sms;
    } else if (state is ProfileStateCatchError) {
      return state.sms;
    } else {
      return 'Error en aplicacion';
    }
  }

  Widget _walletBody(BudgetState state, BuildContext context, int id) {
    if (state is BudgetStateInitial || state is BudgetStateLoading) {
      return const HeaderBudgetMetrics(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CustomCircularProgressBar()],
        ),
      );
    } else if (state is BudgetStateLoadedButEmpty) {
      return HeaderBudgetMetrics(
        assigned: state.wallet.assigned,
        used: state.wallet.used,
        lastUpdate: state.wallet.lastUpdated,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 128,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorPalette.alertGradient)
                  .createShader(bounds),
              child: const Icon(
                Icons.error,
                size: 72,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              _errorWalletMessage(state),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 102,
            ),
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
                  context.read<BudgetCubit>().getWalletAndHistory(id);
                },
                child: const Text('Reintentar',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          ],
        ),
      );
    } else if (state is BudgetStateLoaded) {
      final filteredBudget = state
          .history; //.where((element) => element.name.toLowerCase().contains(state));
      return HeaderBudgetMetrics(
        assigned: state.wallet.assigned,
        used: state.wallet.used,
        lastUpdate: state.wallet.lastUpdated,
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<ContactsCubit>().getMyAllocatedContacts(id);
          },
          child: Scrollbar(
              controller: _scrollController,
              radius: const Radius.circular(45),
              child: ListView.builder(
                  //padding: ,
                  controller: _scrollController,
                  itemCount: filteredBudget.length,
                  itemBuilder: (context, index) {
                    if (index >= filteredBudget.length) {
                      return const Center(child: CustomCircularProgressBar());
                    }
                    return BudgetTile(
                      transaction: filteredBudget[index],
                    );
                  })),
        ),
      );
    } else if (state is BudgetStateTimeout ||
        state is BudgetStateError ||
        state is BudgetStateCatchError) {
      return HeaderBudgetMetrics(
        lastUpdate: undefinedCard,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 128,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorPalette.alertGradient)
                  .createShader(bounds),
              child: const Icon(
                Icons.error,
                size: 72,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              _errorWalletMessage(state),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 102,
            ),
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
                  context.read<BudgetCubit>().getWalletAndHistory(id);
                },
                child: const Text('Reintentar',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  String _errorWalletMessage(BudgetState state) {
    if (state is BudgetStateLoadedButEmpty) {
      return state.message;
    } else if (state is BudgetStateTimeout) {
      return state.message;
    } else if (state is BudgetStateError) {
      return state.message;
    } else if (state is BudgetStateCatchError) {
      return state.message;
    } else {
      return 'Error en aplicacion';
    }
  }
}
