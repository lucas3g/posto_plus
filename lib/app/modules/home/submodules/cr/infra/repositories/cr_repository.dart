import 'package:dio/dio.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/entities/cr.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/repositories/cr_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/infra/adapters/cr_adapter.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/infra/datasources/cr_datasource.dart';
import 'package:result_dart/result_dart.dart';

class CRRepository implements ICRRepository {
  final ICRDataSource dataSource;

  CRRepository({
    required this.dataSource,
  });

  @override
  Future<Result<List<CR>, IMyException>> getResumoCR() async {
    try {
      final result = await dataSource.getResumoCR();

      final List<CR> crs = [];

      crs.addAll(result.map(CRAdapter.fromMap));

      return crs.toSuccess();
    } on IMyException catch (e) {
      return e.toFailure();
    } on DioError catch (e) {
      return MyException(message: e.message!).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
