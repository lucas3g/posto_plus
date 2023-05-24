import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/presenter/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const HomePage(),
    )
  ];
}
