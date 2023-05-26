import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:posto_plus/app/modules/home/presenter/home_page.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/tanques_module.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/vendas_module.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/repositories/ccusto_repository.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/usecases/get_ccustos_usecase.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/external/datasources/ccusto_datasource.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/infra/datasources/ccusto_datasource.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/infra/repositories/ccusto_repository.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';

ModuleRoute configuraModule(
  String name, {
  required Module module,
  TransitionType? transition,
  CustomTransition? customTransition,
  Duration? duration,
  List<RouteGuard> guards = const [],
}) {
  return ModuleRoute(
    name,
    transition: TransitionType.noTransition,
    module: module,
  );
}

class HomeModule extends Module {
  @override
  final List<Module> imports = [
    VendasModule(),
    TanquesModule(),
  ];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<ICCustoDataSource>(
      (i) => CCustoDataSource(
        clientHttp: i(),
      ),
    ),

    //REPOSITORIES
    Bind.factory<ICCustoRepository>(
      (i) => CCustoRepository(
        dataSource: i(),
      ),
    ),

    //USECASES
    Bind.factory<IGetCCustoUseCase>(
      (i) => GetCCustoUseCase(
        repository: i(),
      ),
    ),

    //BLOC
    BlocBind.singleton(
      (i) => CCustoBloc(
        getCCustoUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, args) => HomePage(
              ccustoBloc: Modular.get<CCustoBloc>(),
            ),
        children: [
          configuraModule('/vendas', module: VendasModule()),
          configuraModule('/tanques', module: TanquesModule()),
        ])
  ];
}
