import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../features/crud_contact/presentation/pages/crud_contact_page.dart';
import '../../../features/login/presentation/pages/login_pag.dart';
import '../../../features/main_menu/presentation/pages/main_menu_pag.dart';

String getInitialRoute() {
  return '/auth/login/';
}

Map<String, WidgetBuilder> getAppRoutes() {
  final commonRoutes = <String, WidgetBuilder> {
    '/auth/login/': (context) => const LoginPage(),
    '/main/contacts-wallet': (context) => const MainMenuPage(),
    '/main/contacts-wallet/new-contact': (context) => const CRUDContactPage(),
  };

  //final corporateRoutes = <String, WidgetBuilder> {
  //  '/main/budget-wallet': (context) => const MainMenuPage(),
  //};

  return commonRoutes;
}

//MaterialPageRoute getNotFoundRoute() {
//  return MaterialPageRoute(builder: (context) => const NotFoundPage());
//}