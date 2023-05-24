import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class ILoginUserUseCase {
  AsyncResult<User, IMyException> call(User user);
}

class LoginUserUseCase implements ILoginUserUseCase {
  final IAuthRepository authRepository;

  LoginUserUseCase(this.authRepository);

  @override
  AsyncResult<User, IMyException> call(User user) {
    return user
        .validate()
        .mapError<IMyException>((error) => MyException(message: error))
        .toAsyncResult()
        .flatMap(authRepository.login);
  }
}
