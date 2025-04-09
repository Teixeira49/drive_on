import 'package:drive_on/src/features/login/domain/repository/login_repository_abstract.dart';
import 'package:drive_on/src/features/login/domain/use_cases/login_account_usecase.dart';
import 'package:drive_on/src/shared/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/config/styles/margin.dart';
import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../widgets/create_account_button.dart';
import '../../../../shared/presentation/widgets/floating_snack_bars.dart';
import '../widgets/forgot_password_button.dart';
import '../../../../shared/presentation/widgets/loading_dialog.dart';
import '../../data/datasource/remote/login_datasource_impl.dart';
import '../../data/repository/login_repository_impl.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';
import '../widgets/email_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/password_field.dart';
import '../widgets/title_header.dart';

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

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final LoginDatasourceImpl datasourceImpl = LoginDatasourceImpl();
    final LoginRepository repository = LoginRepositoryImpl(datasourceImpl);
    final loginAccountUseCase = LoginAccountUseCase(repository);

    return BlocProvider(
        create: (_) => LoginCubit(loginAccountUseCase),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (contextCubit, stateCubit) {
            if (stateCubit is LoginStateLoading) {
              LoadingShowDialog.show(contextCubit, 'Iniciando Sesion');
            } else if (stateCubit is LoginStateLoginSuccess) {
              Navigator.pop(contextCubit);
              context.read<UserCubit>().updateUser(stateCubit.user);
              Navigator.of(context)
                  .pushNamed(
                      //Replacement
                      '/main/contacts-wallet', arguments: {'userIndex': stateCubit.user.userType == typePersonal ? 0 : 1});
            } else if (stateCubit is LoginStateLoginFailed) {
                Navigator.pop(contextCubit);
                FloatingWarningSnackBar.show(contextCubit, stateCubit.sms);
            } else {
              Navigator.pop(contextCubit);
              FloatingWarningSnackBar.show(contextCubit, 'Error Desconocido');
            }
          },
          builder: (contextCubit, stateCubit) {
            return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: ColorPalette.authGradientLight)),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                        child: SingleChildScrollView(
                            child: SafeArea(
                                minimum: const EdgeInsets.all(AppSpacing.lg),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const TitleHeader(),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Card(
                                        elevation: ColorPalette.elevationScaleM,
                                        margin:
                                            const EdgeInsets.all(AppSpacing.lg),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        surfaceTintColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppSpacing.lg),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Iniciar Sesion',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              EmailField(
                                                  controller: _emailController),
                                              PasswordField(controller: _passwordController,),
                                              GradientButton(
                                                function: () {
                                                  if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                                    contextCubit
                                                        .read<LoginCubit>()
                                                        .loginAccount(
                                                        _emailController.text,
                                                        _passwordController
                                                            .text);
                                                  } else {
                                                    _formKey.currentState?.validate();
                                                  }
                                                },
                                              ),
                                              const ForgotPasswordButton(),
                                              const CreateAccountButton(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )))),
                    bottomNavigationBar: Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.copyright,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: AppSpacing.xs,
                          ),
                          Text(
                            "Secure Contact: ${_version != 'Cargando...' ? _version : emptyString}. Flembee Tech. C.A.",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )));
          },
        ));
  }
}
