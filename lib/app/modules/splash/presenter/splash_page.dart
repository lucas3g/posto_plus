// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posto_plus/app/app_module.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/events/license_events.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/license_bloc.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/states/license_states.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/my_snackbar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  LicenseBloc? licenseBloc;
  late dynamic user;

  late StreamSubscription sub;

  Future _checkModuleReady() async {
    await Modular.isModuleReady<AppModule>();
  }

  Future _checkUser() async {
    final shared = Modular.get<ILocalStorage>();

    final existeUser = GlobalUser.instance.getUser();

    if (existeUser) {
      user = GlobalUser.instance.user;
    } else {
      user = null;
    }

    if (user != null) {
      final userLogado = user;

      if (userLogado.cnpj.value.contains('97.305.890')) {
        user = null;
        await shared.removeData('user');
        Modular.to.navigate('/auth/');

        BotToast.closeAllLoading();
        BotToast.cleanAll();
        return;
      }

      await _initLicenseBloc();

      BotToast.closeAllLoading();
      BotToast.cleanAll();

      Modular.to.navigate('/home/');
      return;
    }

    BotToast.closeAllLoading();
    BotToast.cleanAll();

    Modular.to.navigate('/auth/');
  }

  Future _initLicenseBloc() async {
    licenseBloc = Modular.get<LicenseBloc>();
    licenseBloc!
        .add(VerifyLicenseEvent(deviceInfo: GlobalDevice.instance.deviceInfo));
  }

  Future init() async {
    BotToast.showText(
      text: 'Validando sua licença. Aguarde...',
      duration: const Duration(seconds: 5),
    );
    BotToast.showLoading(align: Alignment.bottomCenter);

    await _checkModuleReady();
    await Future.delayed(const Duration(seconds: 2));
    await _checkUser();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await init();

      if (licenseBloc != null) {
        sub = licenseBloc!.stream.listen((state) {
          if (state is LicenseNotActive) {
            BotToast.closeAllLoading();
            BotToast.cleanAll();
            MySnackBar(
              title: 'Ops...',
              message:
                  'Licença não esta ativa. Por favor, entre em contato com o suporte',
              type: TypeSnack.warning,
            );
            Modular.to.navigate('/auth/');
            return;
          }

          if (state is LicenseNotFound) {
            BotToast.closeAllLoading();
            BotToast.cleanAll();
            MySnackBar(
              title: 'Ops...',
              message:
                  'Licença não encontrada. Por favor, entre em contato com o suporte',
              type: TypeSnack.warning,
            );
            Modular.to.navigate('/auth/');
            return;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/barra-direita.png',
                    ),
                  ),
                ],
              ),
              Center(
                child: SvgPicture.asset(
                  ThemeModeController.themeMode == ThemeMode.dark
                      ? pathLogoDark
                      : pathLogoLight,
                  width: context.screenWidth,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/barra-esquerda.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
