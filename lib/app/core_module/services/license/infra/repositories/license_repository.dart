// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';
import 'package:posto_plus/app/core_module/services/license/domain/entities/license.dart';
import 'package:posto_plus/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:posto_plus/app/core_module/services/license/infra/adapters/license_adapter.dart';
import 'package:posto_plus/app/core_module/services/license/infra/datasources/license_datasource.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:result_dart/result_dart.dart';

class LicenseRepository implements ILicenseRepository {
  final ILicenseDatasource datasource;

  LicenseRepository({
    required this.datasource,
  });

  @override
  Future<Result<License, IMyException>> verifyLicense(
      DeviceInfo deviceInfo) async {
    try {
      final result = await datasource.verifyLicense(deviceInfo);

      return LicenseAdapter.fromMap(result).toSuccess();
    } on DioError catch (e) {
      return MyException(message: e.message!).toFailure();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<DateTime, IMyException>> getDateLicense() async {
    try {
      final result = await datasource.getDateLicense();

      final date = DateTime.parse(
        result[0]['DATA'].toString().replaceAll('/', '-'),
      );

      return date.toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
