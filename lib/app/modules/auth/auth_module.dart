import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/license_bloc.dart';
import 'package:posto_plus/app/modules/auth/presenter/auth_page.dart';
import 'package:posto_plus/app/modules/auth/presenter/bloc/auth_bloc.dart';

class AuthModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => AuthPage(
        authBloc: Modular.get<AuthBloc>(),
        licenseBloc: Modular.get<LicenseBloc>(),
        deviceInfo: Modular.get<IDeviceInfo>(),
      ),
    )
  ];
}
