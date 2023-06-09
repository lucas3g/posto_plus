import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/events/license_events.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/license_bloc.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/states/license_states.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:posto_plus/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:posto_plus/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:posto_plus/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:posto_plus/app/modules/auth/presenter/controller/auth_controller.dart';
import 'package:posto_plus/app/modules/home/presenter/controller/home_controller.dart';
import 'package:posto_plus/app/shared/components/my_alert_dialog_widget.dart';
import 'package:posto_plus/app/shared/components/my_elevated_button_widget.dart';
import 'package:posto_plus/app/shared/components/my_input_widget.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';
import 'package:posto_plus/app/utils/my_snackbar.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;
  final LicenseBloc licenseBloc;
  final IDeviceInfo deviceInfo;

  const AuthPage({
    Key? key,
    required this.authBloc,
    required this.licenseBloc,
    required this.deviceInfo,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final shared = Modular.get<ILocalStorage>();

  late User user;

  final gkForm = GlobalKey<FormState>();

  final fCNPJ = FocusNode();
  final fUsuario = FocusNode();
  final fSenha = FocusNode();

  late StreamSubscription sub;
  late StreamSubscription subLicense;

  Future getDeviceInfo() async {
    final result = await widget.deviceInfo.getDeviceInfo();

    await shared.setData(
        params: SharedParams(key: 'DEVICE_ID', value: result.deviceID));
  }

  @override
  void initState() {
    super.initState();

    getDeviceInfo();

    user = UserAdapter.empty();

    sub = widget.authBloc.stream.listen((state) async {
      if (state is SuccessAuth) {
        await shared.setData(
          params: SharedParams(
            key: 'user',
            value: UserAdapter.toJson(state.user),
          ),
        );

        GlobalUser.instance.getUser();

        Modular.to.navigate('/home/');
      }

      if (state is ErrorAuth) {
        MySnackBar(
          title: 'Atenção',
          message: state.message,
          type: TypeSnack.error,
          duration: 4,
        );
      }
    });

    subLicense = widget.licenseBloc.stream.listen((state) {
      if (state is LicenseActive) {
        widget.authBloc.add(LoginAuthEvent(user: user));
      }

      if (state is LicenseNotActive) {
        MySnackBar(
          title: 'Atenção',
          message:
              'Licença não ativa. Por favor, entre em contato com o suporte.',
          type: TypeSnack.help,
        );
      }

      if (state is LicenseNotFound) {
        MySnackBar(
          title: 'Atenção',
          message:
              'Licença não encontrada. Por favor, entre em contato com o suporte.',
          type: TypeSnack.warning,
        );
      }

      if (state is ErrorLicense) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: TypeSnack.error,
        );
      }
    });
  }

  Widget retornaLogin(AuthStates state, LicenseStates stateLicense) {
    if (state is LoadingAuth || stateLicense is LoadingLicense) {
      return const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    if (state is SuccessAuth) {
      return const Center(
        child: Icon(Icons.done_rounded),
      );
    }

    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle_rounded),
        SizedBox(width: 10),
        Text(
          'Entrar',
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  void initLogin() async {
    if (!gkForm.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());

    if (!(await HomeController.verifyHasInternet())) {
      MySnackBar(
        title: 'Atenção',
        message: 'Você está sem internet. Por favor verifique sua conexão.',
        type: TypeSnack.help,
      );

      return;
    }

    widget.licenseBloc.add(
      VerifyLicenseEvent(
        deviceInfo: GlobalDevice.instance.deviceInfo,
      ),
    );
  }

  void mostraDialogDemonstracao() {
    showDialog(
        context: context,
        barrierColor: Colors.black38,
        builder: (_) {
          return AlertDialog(
            elevation: 8,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Atenção',
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Divider(),
                Text(
                  'Você irá iniciar uma versão de demonstração os dados são meramente fictícios.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge,
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: MyElevatedButtonWidget(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        },
                        label: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel_rounded),
                            SizedBox(width: 10),
                            Text('Não'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyElevatedButtonWidget(
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');

                          await shared.removeData('user');

                          await shared.setData(
                            params: SharedParams(
                              key: 'user',
                              value: UserAdapter.toJson(
                                User(
                                  id: const IdVO(1),
                                  cnpj: '97.305.890/0001-81',
                                  login: 'ADM',
                                  senha: 'EL',
                                  nome: 'DEMONSTRAÇÃO',
                                ),
                              ),
                            ),
                          );

                          GlobalUser.instance.getUser();

                          Modular.to.navigate('/home/');
                        },
                        label: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done_rounded),
                            SizedBox(width: 10),
                            Text('Iniciar'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void licencaDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black38,
      builder: (context) {
        return MyAlertDialogWidget(
          title: 'Código de Autenticação',
          content: GlobalDevice.instance.deviceInfo.deviceID,
          subContent:
              'Se você já tem uma licença. Por favor, ignore essa mensagem.',
          okButton: MyElevatedButtonWidget(
            height: 45,
            label: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LineIcons.whatSApp),
                SizedBox(width: 5),
                Text('Whats'),
              ],
            ),
            onPressed: () {
              AuthController.openWhatsapp(
                text:
                    'Olá, desejo usar o aplicativo do Posto Plus esse é meu codigo de autenticação: ${GlobalDevice.instance.deviceInfo.deviceID}',
                number: '+555499712433',
              );
            },
          ),
          cancelButton: MyElevatedButtonWidget(
            height: 45,
            label: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.close),
                SizedBox(width: 5),
                Text('Fechar'),
              ],
            ),
            onPressed: () {
              Modular.to.pop('dialog');
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.screenHeight * .94,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                SvgPicture.asset(
                  ThemeModeController.themeMode == ThemeMode.dark
                      ? pathLogoDark
                      : pathLogoLight,
                  width: context.screenWidth,
                ),
                Form(
                  key: gkForm,
                  child: Center(
                    child: Column(
                      children: [
                        MyInputWidget(
                          focusNode: fCNPJ,
                          label: 'CNPJ',
                          hintText: 'Digite o CNPJ da empresa',
                          validator: (v) {
                            late String? result;

                            result =
                                user.cnpj.validate('CNPJ').exceptionOrNull();

                            if (result != null) {
                              return result;
                            }

                            if (!CNPJValidator.isValid(v)) {
                              result = 'CNPJ inválido';
                            }
                            return result;
                          },
                          value: user.cnpj.value,
                          onChanged: (v) => user.setCNPJ(v),
                          keyboardType: TextInputType.number,
                          inputFormaters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CnpjInputFormatter(),
                          ],
                          onFieldSubmitted: (v) => fUsuario.requestFocus(),
                        ),
                        const SizedBox(height: 10),
                        MyInputWidget(
                          focusNode: fUsuario,
                          label: 'Usuário',
                          hintText: 'Digite seu usuário',
                          validator: (v) =>
                              user.login.validate('Usuário').exceptionOrNull(),
                          value: user.login.value,
                          onChanged: (v) => user.setLogin(v),
                          inputFormaters: [UpperCaseTextFormatter()],
                          onFieldSubmitted: (v) => fSenha.requestFocus(),
                        ),
                        const SizedBox(height: 10),
                        MyInputWidget(
                          focusNode: fSenha,
                          obscureText: true,
                          maxLines: 1,
                          label: 'Senha',
                          hintText: 'Digite sua senha',
                          validator: (v) =>
                              user.senha.validate('Senha').exceptionOrNull(),
                          value: user.senha.value,
                          onChanged: (v) => user.setSenha(v),
                          inputFormaters: [UpperCaseTextFormatter()],
                          onFieldSubmitted: (v) {
                            initLogin();
                          },
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<LicenseBloc, LicenseStates>(
                            bloc: widget.licenseBloc,
                            builder: (context, licenseState) {
                              return BlocBuilder<AuthBloc, AuthStates>(
                                bloc: widget.authBloc,
                                builder: (context, state) {
                                  return MyElevatedButtonWidget(
                                    height: 40,
                                    label: retornaLogin(state, licenseState),
                                    onPressed: initLogin,
                                  );
                                },
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: licencaDialog,
                              child: Text(
                                'Licença para acessar',
                                style: context.textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: mostraDialogDemonstracao,
                      child: Text(
                        'Versão de demonstração',
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    const Text('EL Sistemas - 2023 - 54 3364-1588'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
