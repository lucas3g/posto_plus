import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';

abstract class LicenseEvents {}

class VerifyLicenseEvent extends LicenseEvents {
  final DeviceInfo deviceInfo;

  VerifyLicenseEvent({
    required this.deviceInfo,
  });
}

class GetDateLicenseEvent extends LicenseEvents {}
