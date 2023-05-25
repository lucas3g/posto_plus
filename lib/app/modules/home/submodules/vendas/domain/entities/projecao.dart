import 'package:posto_plus/app/core_module/types/entity.dart';
import 'package:posto_plus/app/core_module/vos/double_vo.dart';
import 'package:posto_plus/app/core_module/vos/id_vo.dart';

class Projecao extends Entity {
  final IdVO _ccusto;
  final DoubleVO _vendaDiaria;
  final DoubleVO _qtdDiaria;
  final DoubleVO _vendaSemanal;
  final DoubleVO _qtdSemanal;
  final DoubleVO _vendaProjecao;
  final DoubleVO _qtdProjecao;

  IdVO get ccusto => _ccusto;

  DoubleVO get vendaDiaria => _vendaDiaria;
  DoubleVO get qtdDiaria => _qtdDiaria;
  DoubleVO get vendaSemanal => _vendaSemanal;
  DoubleVO get qtdSemanal => _qtdSemanal;
  DoubleVO get vendaProjecao => _vendaProjecao;
  DoubleVO get qtdProjecao => _qtdProjecao;

  Projecao({
    required super.id,
    required int ccusto,
    required double vendaDiaria,
    required double qtdDiaria,
    required double vendaSemanal,
    required double qtdSemanal,
    required double vendaProjecao,
    required double qtdProjecao,
  })  : _ccusto = IdVO(ccusto),
        _vendaDiaria = DoubleVO(vendaDiaria),
        _qtdDiaria = DoubleVO(qtdDiaria),
        _vendaSemanal = DoubleVO(vendaSemanal),
        _qtdSemanal = DoubleVO(qtdSemanal),
        _vendaProjecao = DoubleVO(vendaProjecao),
        _qtdProjecao = DoubleVO(qtdProjecao);
}
