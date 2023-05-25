import 'package:dio/dio.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/projecao.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/infra/adapters/projecao_adapter.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/infra/datasources/vendas_datasource.dart';
import 'package:result_dart/result_dart.dart';

class VendasRepository implements IVendasRepository {
  final IVendasDatasource datasource;

  VendasRepository({
    required this.datasource,
  });
  @override
  Future<Result<List<Projecao>, IMyException>> getProjecao() async {
    try {
      final result = await datasource.getProjecao();

      final projecoes = result.map(ProjecaoAdapter.fromMap).toList();

      return projecoes.toSuccess();
    } on IMyException catch (e) {
      return e.toFailure();
    } on DioError catch (e) {
      return MyException(message: e.message!).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
