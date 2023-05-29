import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/entities/preco_cliente.dart';
import 'package:result_dart/result_dart.dart';

abstract class IPrecoClienteRepository {
  Future<Result<List<PrecoCliente>, IMyException>> getPrecos();
}
