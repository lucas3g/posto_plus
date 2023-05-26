import 'package:posto_plus/app/core_module/types/entity.dart';
import 'package:posto_plus/app/core_module/vos/double_vo.dart';
import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/core_module/vos/int_vo.dart';
import 'package:posto_plus/app/core_module/vos/text_vo.dart';

class Tanques extends Entity {
  final IdVO _ccusto;
  final TextVO _descricao;
  TextVO _descResumida;
  final IntVO _capacidade;
  final IntVO _tanque;
  DoubleVO _volume;

  IdVO get ccusto => _ccusto;
  TextVO get descricao => _descricao;
  TextVO get descResumida => _descResumida;
  void setDescResumida(String value) => _descResumida = TextVO(value);
  IntVO get capacidade => _capacidade;
  IntVO get tanque => _tanque;
  DoubleVO get volume => _volume;
  void setVolume(double value) => _volume = DoubleVO(value);

  Tanques({
    required super.id,
    required int ccusto,
    required String descricao,
    required String descResumida,
    required int capacidade,
    required int tanque,
    required double volume,
  })  : _ccusto = IdVO(ccusto),
        _descricao = TextVO(descricao),
        _descResumida = TextVO(descResumida),
        _capacidade = IntVO(capacidade),
        _tanque = IntVO(tanque),
        _volume = DoubleVO(volume);
}
