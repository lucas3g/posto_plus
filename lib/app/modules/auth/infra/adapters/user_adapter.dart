import 'dart:convert';

import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';

class UserAdapter {
  static String toJson(User user) {
    return jsonEncode({
      'CNPJ': user.cnpj.value,
      'USUARIO': user.login.value,
      'SENHA': user.senha.value,
    });
  }

  static Map<String, dynamic> toMap(User user) {
    return {
      'CNPJ': user.cnpj.value,
      'USUARIO': user.login.value,
      'SENHA': user.senha.value,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: const IdVO(1),
      cnpj: map['CNPJ'],
      login: map['USUARIO'],
      senha: map['SENHA'],
    );
  }

  static User empty() {
    return User(id: const IdVO(1), cnpj: '', login: '', senha: '');
  }
}
