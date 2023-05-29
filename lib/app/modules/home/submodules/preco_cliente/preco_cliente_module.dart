import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/repositories/preco_cliente_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/usecases/get_preco_clientes_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/external/datasources/preco_cliente_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/infra/datasources/preco_cliente_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/infra/repositories/preco_cliente_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/preco_cliente_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/preco_cliente_page.dart';

class PrecoClienteModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<IPrecoClienteDatasource>(
      (i) => PrecoClienteDatasource(
        clientHttp: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IPrecoClienteRepository>(
      (i) => PrecoClienteRepository(
        datasource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetPrecoClienteUseCase>(
      (i) => GetPrecoClienteUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOCS
    BlocBind.singleton<PrecoClienteBloc>(
      (i) => PrecoClienteBloc(
        getPrecoClienteUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => PrecoClientePage(
        precoClienteBloc: Modular.get<PrecoClienteBloc>(),
      ),
    )
  ];
}
