import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';

abstract class ILicenseDatasource {
  Future<Map<String, dynamic>> verifyLicense(DeviceInfo deviceInfo);
}
