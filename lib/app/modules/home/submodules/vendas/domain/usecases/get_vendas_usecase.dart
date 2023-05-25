import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/vendas.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetVendasUseCase {
  AsyncResult<List<Vendas>, IMyException> call();
}

class GetVendasUseCase implements IGetVendasUseCase {
  final IVendasRepository repository;

  GetVendasUseCase({required this.repository});

  @override
  AsyncResult<List<Vendas>, IMyException> call() async {
    return await repository.getVendas();
  }
}
