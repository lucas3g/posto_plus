import 'package:posto_plus/app/core_module/types/entity.dart';
import 'package:posto_plus/app/core_module/vos/text_vo.dart';
import 'package:result_dart/result_dart.dart';

class User extends Entity {
  TextVO _cnpj;
  TextVO _nome;
  TextVO _login;
  TextVO _senha;

  TextVO get cnpj => _cnpj;
  void setCNPJ(String value) => _cnpj = TextVO(value);

  TextVO get nome => _nome;
  void setNome(String value) => _nome = TextVO(value);

  TextVO get login => _login;
  void setLogin(String value) => _login = TextVO(value);

  TextVO get senha => _senha;
  void setSenha(String value) => _senha = TextVO(value);

  User({
    required super.id,
    required String cnpj,
    String? nome,
    required String login,
    required String senha,
  })  : _cnpj = TextVO(cnpj),
        _nome = TextVO(nome ?? ''),
        _login = TextVO(login),
        _senha = TextVO(senha);

  @override
  Result<User, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(cnpj.validate)
        .flatMap(login.validate)
        .flatMap(senha.validate)
        .pure(this);
  }
}
