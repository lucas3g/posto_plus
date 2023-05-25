import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/entities/ccusto_entity.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/repositories/ccusto_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetCCustoUseCase {
  AsyncResult<List<CCusto>, IMyException> call();
}

class GetCCustoUseCase implements IGetCCustoUseCase {
  final ICCustoRepository repository;

  GetCCustoUseCase({required this.repository});

  @override
  AsyncResult<List<CCusto>, IMyException> call() async {
    return await repository.getCCustos();
  }
}
