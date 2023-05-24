import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/client_http/client_http_interface.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:posto_plus/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthDatasource implements IAuthDatasource {
  final IClientHttp clientHttp;

  AuthDatasource(this.clientHttp);

  @override
  Future<Map<String, dynamic>> login(User user) async {
    final cnpj =
        UtilBrasilFields.removeCaracteres(user.cnpj.value).substring(0, 8);

    final result = await clientHttp.post(
      '$baseUrl/login/$cnpj',
      data: UserAdapter.toJson(user),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao tentar fazer login.');
    }

    if (result.data.toString().trim() == '[]') {
      throw const MyException(message: 'Usuário ou senha incorreta.');
    }

    if (jsonDecode(result.data)['APP_POSTO'] == 'N') {
      throw const MyException(message: 'Usuário sem permissão para acessar.');
    }

    return UserAdapter.toMap(user);
  }
}
