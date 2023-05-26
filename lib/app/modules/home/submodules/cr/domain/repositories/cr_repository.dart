import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/entities/cr.dart';
import 'package:result_dart/result_dart.dart';

abstract class ICRRepository {
  Future<Result<List<CR>, IMyException>> getResumoCR();
}
