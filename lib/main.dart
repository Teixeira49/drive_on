import 'package:drive_on/src/shared/presentation/cubit/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/config/routes/routes.dart';
import 'src/core/config/styles/themes.dart';
import 'src/shared/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'src/shared/presentation/cubit/user_cubit/user_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider(create: (_) => UserCubit()),
        ],
        child:
            BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
          return BlocBuilder<UserCubit, UserState>(
              builder: (context, stateUser) {
            return MaterialApp(
              title: 'Flutter D Project APP',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              themeAnimationCurve: Curves.elasticIn,
              debugShowCheckedModeBanner: false,
              routes: getAppRoutes(),
              // change for generative route
              initialRoute: getInitialRoute(),
              //onUnknownRoute: (RouteSettings setting) {
              //  return getNotFoundRoute();
              //},
              home: getInitialRoutePage(),
            );
          });
        }));
  }
}
