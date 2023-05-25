import 'package:posto_plus/app/core_module/types/entity.dart';
import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/core_module/vos/text_vo.dart';
import 'package:result_dart/result_dart.dart';

class CCusto extends Entity {
  TextVO _descricao;
  IdVO _ccusto;

  TextVO get descricao => _descricao;
  void setDescricao(String value) => _descricao = TextVO(value);

  IdVO get ccusto => _ccusto;
  void setCCusto(int value) => _ccusto = IdVO(value);

  CCusto({
    required super.id,
    required String descricao,
    required int ccusto,
  })  : _descricao = TextVO(descricao),
        _ccusto = IdVO(ccusto);

  @override
  Result<CCusto, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(descricao.validate)
        .flatMap(ccusto.validate)
        .pure(this);
  }
}
