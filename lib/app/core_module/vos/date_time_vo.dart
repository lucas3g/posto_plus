// ignore_for_file: unused_local_variable

import 'package:posto_plus/app/core_module/vos/value_object.dart';
import 'package:result_dart/result_dart.dart';

class DateTimeVO extends ValueObject<DateTime> {
  const DateTimeVO(super.value);

  bool isDateValid(int year, int month, int day) {
    try {
      DateTime date = DateTime(year, month, day);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Result<DateTimeVO, String> validate([Object? object]) {
    if (isDateValid(value.year, value.month, value.day)) {
      return 'Data inválida'.toFailure();
    }
    return Success(this);
  }
}
