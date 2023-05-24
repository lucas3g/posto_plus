import 'package:posto_plus/app/core_module/vos/value_object.dart';
import 'package:result_dart/result_dart.dart';

class DoubleVO extends ValueObject<double> {
  const DoubleVO(super.value);

  @override
  Result<DoubleVO, String> validate([Object? object]) {
    if (value < 0.0) {
      return '$runtimeType não pode ser menor que zero'.toFailure();
    }
    return Success(this);
  }
}
