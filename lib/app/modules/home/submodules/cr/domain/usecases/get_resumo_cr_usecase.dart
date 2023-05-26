import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/entities/cr.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/repositories/cr_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetResumoCRUseCase {
  AsyncResult<List<CR>, IMyException> call();
}

class GetResumoCRUseCase implements IGetResumoCRUseCase {
  final ICRRepository repository;

  GetResumoCRUseCase({
    required this.repository,
  });

  @override
  AsyncResult<List<CR>, IMyException> call() async {
    return await repository.getResumoCR();
  }
}
