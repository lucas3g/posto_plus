// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/entities/tanques.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/repositories/tanques_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetTanquesUseCase {
  AsyncResult<List<Tanques>, IMyException> call();
}

class GetTanquesUseCase implements IGetTanquesUseCase {
  final ITanquesRepository repository;

  GetTanquesUseCase({
    required this.repository,
  });

  @override
  AsyncResult<List<Tanques>, IMyException> call() async {
    return await repository.getTanques();
  }
}
