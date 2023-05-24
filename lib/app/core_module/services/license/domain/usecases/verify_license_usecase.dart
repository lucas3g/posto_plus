// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';
import 'package:posto_plus/app/core_module/services/license/domain/entities/license.dart';
import 'package:posto_plus/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IVerifyLicenseUseCase {
  Future<Result<License, IMyException>> call(DeviceInfo deviceInfo);
}

class VerifyLicenseUseCase implements IVerifyLicenseUseCase {
  final ILicenseRepository repository;

  VerifyLicenseUseCase({
    required this.repository,
  });

  @override
  Future<Result<License, IMyException>> call(DeviceInfo deviceInfo) async {
    return await repository.verifyLicense(deviceInfo);
  }
}
