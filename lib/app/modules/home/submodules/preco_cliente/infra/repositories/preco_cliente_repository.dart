import 'package:dio/dio.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/entities/preco_cliente.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/repositories/preco_cliente_repository.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/infra/adapters/preco_cliente_adapter.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/infra/datasources/preco_cliente_datasource.dart';
import 'package:result_dart/result_dart.dart';

class PrecoClienteRepository implements IPrecoClienteRepository {
  final IPrecoClienteDatasource datasource;

  PrecoClienteRepository({
    required this.datasource,
  });
  @override
  Future<Result<List<PrecoCliente>, IMyException>> getPrecos() async {
    try {
      final result = await datasource.getPrecos();

      final List<PrecoCliente> precos = [];

      precos.addAll(result.map(PrecoClienteAdapter.fromMap));

      return precos.toSuccess();
    } on IMyException catch (e) {
      return e.toFailure();
    } on DioError catch (e) {
      return MyException(message: e.message!).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
