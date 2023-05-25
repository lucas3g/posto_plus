import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/vendas_page.dart';

class VendasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const VendasPage(),
    )
  ];
}
