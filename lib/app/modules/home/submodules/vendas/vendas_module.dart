import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/usecases/get_projecao_vendas_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/usecases/get_vendas_grafico_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/external/datasources/vendas_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/infra/datasources/vendas_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/infra/repositories/vendas_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/grafico_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/projecao_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/vendas_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/vendas_page.dart';

class VendasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCE
    Bind.factory<IVendasDatasource>(
      (i) => VendasDatasource(
        clientHttp: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IVendasRepository>(
      (i) => VendasRepository(
        datasource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetProjecaoVendasUseCase>(
      (i) => GetProjecaoVendasUseCase(
        repository: i(),
      ),
      export: true,
    ),
    Bind.factory<IGetVendasGraficoUseCase>(
      (i) => GetVendasGraficoUseCase(
        repository: i(),
      ),
      export: true,
    ),
    Bind.factory<IGetVendasUseCase>(
      (i) => GetVendasUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOC
    BlocBind.singleton<ProjecaoBloc>(
      (i) => ProjecaoBloc(
        getProjecaoUseCase: i(),
      ),
      export: true,
    ),
    BlocBind.singleton<GraficoBloc>(
      (i) => GraficoBloc(
        getVendasGraficoUseCase: i(),
      ),
      export: true,
    ),
    BlocBind.singleton<VendasBloc>(
      (i) => VendasBloc(
        getVendasUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => VendasPage(
        projecaoBloc: Modular.get<ProjecaoBloc>(),
        graficoBloc: Modular.get<GraficoBloc>(),
        vendasBloc: Modular.get<VendasBloc>(),
      ),
    )
  ];
}
