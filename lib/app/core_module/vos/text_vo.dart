import 'package:posto_plus/app/core_module/vos/value_object.dart';
import 'package:result_dart/result_dart.dart';

class TextVO extends ValueObject<String> {
  const TextVO(super.value);

  @override
  Result<TextVO, String> validate([Object? object]) {
    if (value.isEmpty) {
      return '$object não pode ser vazio'.toFailure();
    }
    return Success(this);
  }
}
