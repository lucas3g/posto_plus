import 'package:posto_plus/app/core_module/types/entity.dart';
import 'package:posto_plus/app/core_module/vos/double_vo.dart';
import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/core_module/vos/text_vo.dart';

class CR extends Entity {
  final IdVO _ccusto;
  final TextVO _nome;
  final DoubleVO _valor;

  IdVO get ccusto => _ccusto;
  TextVO get nome => _nome;
  DoubleVO get valor => _valor;

  CR({
    required super.id,
    required int ccusto,
    required String nome,
    required double valor,
  })  : _ccusto = IdVO(ccusto),
        _nome = TextVO(nome),
        _valor = DoubleVO(valor);
}
