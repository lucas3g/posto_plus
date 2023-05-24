import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class IAuthRepository {
  Future<Result<User, IMyException>> login(User user);
}
