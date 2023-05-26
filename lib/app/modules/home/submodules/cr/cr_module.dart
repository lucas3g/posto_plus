import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/repositories/cr_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/usecases/get_resumo_cr_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/external/datasources/cr_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/infra/datasources/cr_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/infra/repositories/cr_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/cr_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/cr_page.dart';

class CRModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<ICRDataSource>(
      (i) => CRDataSource(
        clientHttp: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<ICRRepository>(
      (i) => CRRepository(
        dataSource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetResumoCRUseCase>(
      (i) => GetResumoCRUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOCS
    BlocBind.singleton<CRBloc>(
      (i) => CRBloc(
        getResumoCRUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => CRPage(
        crBloc: Modular.get<CRBloc>(),
      ),
    )
  ];
}
