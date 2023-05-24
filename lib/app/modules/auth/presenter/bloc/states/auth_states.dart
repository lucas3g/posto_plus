import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/infra/adapters/user_adapter.dart';

abstract class AuthStates {
  final User user;

  AuthStates({required this.user});

  LoadingAuth loading() {
    return LoadingAuth(user: user);
  }

  SuccessAuth success(User? user) {
    return SuccessAuth(user: user ?? this.user);
  }

  ErrorAuth error(String message) {
    return ErrorAuth(user: user, message: message);
  }
}

class InitialAuth extends AuthStates {
  InitialAuth() : super(user: UserAdapter.empty());
}

class LoadingAuth extends AuthStates {
  LoadingAuth({required super.user});
}

class SuccessAuth extends AuthStates {
  SuccessAuth({required super.user});
}

class ErrorAuth extends AuthStates {
  final String message;

  ErrorAuth({
    required super.user,
    required this.message,
  });
}
