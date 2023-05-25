import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/grafico.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetVendasGraficoUseCase {
  AsyncResult<List<Grafico>, IMyException> call();
}

class GetVendasGraficoUseCase implements IGetVendasGraficoUseCase {
  final IVendasRepository repository;

  GetVendasGraficoUseCase({required this.repository});

  @override
  AsyncResult<List<Grafico>, IMyException> call() async {
    return await repository.getGrafico();
  }
}
