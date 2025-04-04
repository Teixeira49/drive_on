import 'package:drive_on/src/features/login/domain/repository/login_repository_abstract.dart';
import 'package:drive_on/src/features/login/domain/use_cases/login_account_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../core/config/styles/margin.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../data/datasource/remote/login_datasource_impl.dart';
import '../../data/repository/login_repository_impl.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State<LoginPage> {
  String _version = 'Cargando...';

  @override
  void initState() {
    _loadVersion();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${packageInfo.version}+${packageInfo.buildNumber}';
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //@override
  //void dispose() {
  //  _emailController.dispose();
  //  _passwordController.dispose();
  //  super.dispose();
  //}

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final LoginDatasourceImpl datasourceImpl = LoginDatasourceImpl();
    final LoginRepository repository = LoginRepositoryImpl(datasourceImpl);
    final loginAccountUseCase = LoginAccountUseCase(repository);

    return BlocProvider(
        create: (_) => LoginCubit(loginAccountUseCase),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (contextCubit, stateCubit) {},
          builder: (contextCubit, stateCubit) {
            return Scaffold(
                body: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.white,
                          Colors.grey[50]!,
                          Colors.grey[50]!,
                          Colors.grey[50]!,
                          Colors.cyan,
                          Colors.blue
                        ])),
                    child: SafeArea(
                        minimum: const EdgeInsets.all(AppSpacing.lg),
                        child: Center(
                            child: SingleChildScrollView(
                                child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_box,
                                      size: 32,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Flexible(
                                      child: GradientText(
                                        'Secure Contact',
                                        gradientDirection:
                                            GradientDirection.ttb,
                                        style: const TextStyle(
                                          fontSize: 40.0,
                                        ),
                                        colors: [
                                          Colors.blue,
                                          Colors.cyanAccent,
                                          //Colors.tealAccent,
                                        ],
                                      ),
                                    )
                                  ]),
                              SizedBox(
                                height: 32,
                              ),
                              Card(
                                elevation: 10,
                                margin: EdgeInsets.all(24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                surfaceTintColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Iniciar Sesion', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 24, bottom: 12),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: "Email"),
                                        ),
                                      ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 12),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: isObscured
                                                  ? const Icon(
                                                      Icons.visibility_off)
                                                  : const Icon(
                                                      Icons.visibility),
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              onPressed: () {
                                                setState(() {
                                                  isObscured = !isObscured;
                                                });
                                              },
                                            ),
                                            labelText: "Contraseña"),
                                      ),),
                                      Padding(
                                          padding: EdgeInsets.symmetric(vertical: 12),
                                        child:
                                      Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Colors.lightBlueAccent
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              30.0), // Uniform radius
                                        ),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 8)),
                                            onPressed: () {},
                                            child: const Text(
                                              'Continue',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ),),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text("Forgot Password",
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "¿No tienes una cuenta? ",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              children: [
                                            TextSpan(
                                                text: 'Registrate',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        print('registrar');
                                                      })
                                          ]))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                        ))))),
                bottomNavigationBar: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.copyright,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                          "Version: ${_version != 'Cargando...' ? _version : emptyString}. Flembee Inc."),
                    ],
                  ),
                ));
          },
        ));
  }
}
