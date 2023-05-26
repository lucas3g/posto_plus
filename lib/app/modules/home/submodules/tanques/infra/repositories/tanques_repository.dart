import 'package:dio/dio.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/entities/tanques.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/repositories/tanques_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/infra/adapters/tanques_adapter.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/infra/datasources/tanques_datasource.dart';
import 'package:result_dart/result_dart.dart';

class TanquesRepository implements ITanquesRepository {
  final ITanquesDatasource datasource;

  TanquesRepository({
    required this.datasource,
  });

  @override
  Future<Result<List<Tanques>, IMyException>> getTanques() async {
    try {
      final result = await datasource.getTanques();

      final tanques = result.map(TanquesAdapter.fromMap).toList();

      return tanques.toSuccess();
    } on IMyException catch (e) {
      return e.toFailure();
    } on DioError catch (e) {
      return MyException(message: e.message!).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
