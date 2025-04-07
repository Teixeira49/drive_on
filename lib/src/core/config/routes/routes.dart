import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../features/login/presentation/pages/login_pag.dart';
import '../../../features/main_menu/presentation/pages/main_menu_pag.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';

String getInitialRoute() {
  return '/auth/login/';
}

Map<String, WidgetBuilder> getAppRoutes() {
  final commonRoutes = <String, WidgetBuilder> {
    '/auth/login/': (context) => const LoginPage(),
    '/main/contacts-wallet': (context) => const MainMenuPage(),
    '/main/profile-user': (context) => const ProfilePage(),
  };

  //final corporateRoutes = <String, WidgetBuilder> {
  //  '/main/budget-wallet': (context) => const MainMenuPage(),
  //};

  return commonRoutes;
}

//MaterialPageRoute getNotFoundRoute() {
//  return MaterialPageRoute(builder: (context) => const NotFoundPage());
//}