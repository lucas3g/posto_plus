import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';

abstract class IAuthDatasource {
  Future<Map<String, dynamic>> login(User user);
}
