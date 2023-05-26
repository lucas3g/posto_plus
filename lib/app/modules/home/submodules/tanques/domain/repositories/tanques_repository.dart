import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/entities/tanques.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITanquesRepository {
  Future<Result<List<Tanques>, IMyException>> getTanques();
}
