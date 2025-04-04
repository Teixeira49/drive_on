import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../features/main_menu/presentation/pages/main_menu_pag.dart';

String getInitialRoute() {
  return '/auth/login/';
}

Map<String, WidgetBuilder> getAppRoutes() {
  final commonRoutes = <String, WidgetBuilder> {
    '/main/contacts-wallet': (context) => const MainMenuPage(),
  };

  //final corporateRoutes = <String, WidgetBuilder> {
  //  '/main/budget-wallet': (context) => const MainMenuPage(),
  //};

  return commonRoutes;
}

//MaterialPageRoute getNotFoundRoute() {
//  return MaterialPageRoute(builder: (context) => const NotFoundPage());
//}