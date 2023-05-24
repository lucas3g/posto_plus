import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';

abstract class AuthEvents {}

class LoginAuthEvent extends AuthEvents {
  final User user;

  LoginAuthEvent({
    required this.user,
  });
}
