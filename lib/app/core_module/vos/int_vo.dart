import 'package:posto_plus/app/core_module/vos/value_object.dart';
import 'package:result_dart/result_dart.dart';

class IntVo extends ValueObject<int> {
  const IntVo(super.value);

  @override
  Result<IntVo, String> validate([Object? object]) {
    if (value < 0) {
      return '$runtimeType não pode ser menor que zero'.toFailure();
    }
    return Success(this);
  }
}
