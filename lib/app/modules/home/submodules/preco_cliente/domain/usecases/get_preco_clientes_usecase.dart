import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/entities/preco_cliente.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/repositories/preco_cliente_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetPrecoClienteUseCase {
  AsyncResult<List<PrecoCliente>, IMyException> call();
}

class GetPrecoClienteUseCase implements IGetPrecoClienteUseCase {
  final IPrecoClienteRepository repository;

  GetPrecoClienteUseCase({
    required this.repository,
  });

  @override
  AsyncResult<List<PrecoCliente>, IMyException> call() async {
    return await repository.getPrecos();
  }
}
