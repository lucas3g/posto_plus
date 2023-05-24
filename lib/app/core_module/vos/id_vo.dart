import 'package:posto_plus/app/core_module/vos/value_object.dart';
import 'package:result_dart/result_dart.dart';

class IdVO extends ValueObject<int> {
  const IdVO(super.value);

  @override
  Result<IdVO, String> validate([Object? object]) {
    if (value <= 0) {
      return '$runtimeType não pode ser menor que zero'.toFailure();
    }
    return Success(this);
  }
}
