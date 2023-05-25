import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/projecao.dart';
import 'package:result_dart/result_dart.dart';

abstract class IVendasRepository {
  Future<Result<List<Projecao>, IMyException>> getProjecao();
}
