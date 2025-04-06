import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/contacts_cubit/contacts_cubit.dart';
import '../cubit/contacts_cubit/contacts_state.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenuPage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ContactsCubit(ContactsStateInitial()),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('pepe'),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [Text('Data'), Text("test")],
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
            NavigationDestination(
              icon: Icon(Icons.wallet_outlined),
              selectedIcon: Icon(Icons.wallet),
              label: 'Presupuesto',
            ),
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Inicio'),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
              tooltip: 'pepe',
            ),
          ],
        ),
      ),
    );
  }
//context.read<UserCubit>().getUser();
}
