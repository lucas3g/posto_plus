import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/repositories/tanques_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/usecases/get_tanques_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/external/datasources/tanques_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/infra/datasources/tanques_datasource.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/infra/repositories/tanques_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/tanques_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/tanques_page.dart';

class TanquesModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCE
    Bind.factory<ITanquesDatasource>(
      (i) => TanquesDatasource(
        clientHttp: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<ITanquesRepository>(
      (i) => TanquesRepository(
        datasource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetTanquesUseCase>(
      (i) => GetTanquesUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOC
    BlocBind.singleton<TanquesBloc>(
      (i) => TanquesBloc(
        getTanquesUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => TanquesPage(
        tanquesBloc: Modular.get<TanquesBloc>(),
      ),
    )
  ];
}
