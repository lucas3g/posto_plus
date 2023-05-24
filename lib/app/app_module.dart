import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:posto_plus/app/core_module/core_module.dart';
import 'package:posto_plus/app/core_module/services/realm/realm_config.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_service.dart';
import 'package:posto_plus/app/modules/auth/auth_module.dart';
import 'package:posto_plus/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:posto_plus/app/modules/auth/domain/usecases/login_user_usecase.dart';
import 'package:posto_plus/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:posto_plus/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:posto_plus/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:posto_plus/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:posto_plus/app/modules/home/home_module.dart';
import 'package:posto_plus/app/modules/splash/splash_module.dart';
import 'package:posto_plus/app/shared/stores/app_store.dart';
import 'package:realm/realm.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    SplashModule(),
    AuthModule(),
    HomeModule(),
  ];

  @override
  final List<Bind> binds = [
    //DATABASE
    Bind.instance<Realm>(Realm(config)),

    //STORES
    Bind.singleton<AppStore>((i) => AppStore(i())),

    //THEME MODE
    Bind.factory<IThemeMode>(
      (i) => ThemeModeService(realm: i()),
    ),

    //DATASOURCES
    Bind.factory<IAuthDatasource>((i) => AuthDatasource(i())),

    //REPOSITORIES
    Bind.factory<IAuthRepository>((i) => AuthRepository(i())),

    //USECASES
    Bind.factory<ILoginUserUseCase>(
      (i) => LoginUserUseCase(i()),
    ),

    //BLOC
    BlocBind.factory<AuthBloc>(
      (i) => AuthBloc(
        loginUserUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
