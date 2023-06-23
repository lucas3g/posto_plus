import 'package:dio/dio.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:posto_plus/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:posto_plus/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource authDatasource;

  AuthRepository(this.authDatasource);

  @override
  Future<Result<User, IMyException>> login(User user) async {
    try {
      final result = await authDatasource.login(user);

      return UserAdapter.fromMap(result).toSuccess();
    } on IMyException catch (e) {
      return e.toFailure();
    } on DioException catch (e) {
      return MyException(message: e.message ?? 'Erro ao tentar entrar')
          .toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
