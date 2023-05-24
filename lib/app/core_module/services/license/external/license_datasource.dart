import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/client_http/client_http_interface.dart';
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';
import 'package:posto_plus/app/core_module/services/license/infra/datasources/license_datasource.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';

class LicenseDatasource implements ILicenseDatasource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  LicenseDatasource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<Map<String, dynamic>> verifyLicense(DeviceInfo deviceInfo) async {
    clientHttp.setHeaders({'cnpj': 'licenca', 'id': deviceInfo.deviceID});

    final response = await clientHttp.get('$baseUrlLicense/licenca');

    await Future.delayed(const Duration(milliseconds: 600));

    if (response.statusCode != 200) {
      throw MyException(
        message: 'Error ao tentar verificar licença',
        stackTrace: StackTrace.current,
      );
    }

    clientHttp.setHeaders({'Content-Type': 'application/json'});

    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> getDateLicense() async {
    final result = await localStorage.getData('LICENSE');

    return result;
  }
}
