import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';
import 'package:posto_plus/app/core_module/services/device_info/platform_device_info.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/license_bloc.dart';
import 'package:posto_plus/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:posto_plus/app/core_module/services/license/domain/usecases/get_date_license_usecase.dart';
import 'package:posto_plus/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';
import 'package:posto_plus/app/core_module/services/license/external/license_datasource.dart';
import 'package:posto_plus/app/core_module/services/license/infra/datasources/license_datasource.dart';
import 'package:posto_plus/app/core_module/services/license/infra/repositories/license_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/client_http/client_http_interface.dart';
import 'services/client_http/dio_client_http.dart';
import 'services/shared_preferences/local_storage_interface.dart';
import 'services/shared_preferences/shared_preferences_service.dart';

Bind<Dio> _dioFactory() {
  final baseOptions = BaseOptions(
    // baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
  );
  return Bind.factory<Dio>((i) => Dio(baseOptions), export: true);
}

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    //DIO
    _dioFactory(),

    //CLIENTHTTP
    Bind.factory<IClientHttp>(
      (i) => DioClientHttp(i()),
      export: true,
    ),

    //SHARED PREFERENCES
    AsyncBind<SharedPreferences>(
      (i) => SharedPreferences.getInstance(),
      export: true,
    ),

    //LOCAL STORAGE
    Bind<ILocalStorage>(
      ((i) => SharedPreferencesService(sharedPreferences: i())),
      export: true,
    ),

    Bind.factory<IDeviceInfo>(
      (i) => PlatformDeviceInfo(),
      export: true,
    ),

    //DATASOURCES
    Bind.factory<ILicenseDatasource>(
      (i) => LicenseDatasource(
        clientHttp: i(),
        localStorage: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<ILicenseRepository>(
      (i) => LicenseRepository(
        datasource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IVerifyLicenseUseCase>(
      (i) => VerifyLicenseUseCase(
        repository: i(),
      ),
      export: true,
    ),

    Bind.factory<IGetDateLicenseUseCase>(
      (i) => GetDateLicenseUseCase(
        repository: i(),
      ),
      export: true,
    ),

    BlocBind.factory<LicenseBloc>(
      (i) => LicenseBloc(
        verifyLicenseUseCase: i(),
        getDateLicenseUseCase: i(),
      ),
      export: true,
    ),
  ];
}
