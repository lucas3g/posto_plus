import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/entities/ccusto_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract class ICCustoRepository {
  Future<Result<List<CCusto>, IMyException>> getCCustos();
}
