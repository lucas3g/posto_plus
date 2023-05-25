import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/projecao.dart';

class ProjecaoAdapter {
  static Projecao fromMap(dynamic map) {
    return Projecao(
      id: const IdVO(1),
      ccusto: map['CCUSTO'],
      vendaDiaria: map['VENDA_DIARIA'],
      qtdDiaria: map['QTD_DIARIA'],
      vendaSemanal: map['VENDA_SEMANAL'],
      qtdSemanal: map['QTD_SEMANAL'],
      vendaProjecao: map['VENDA_PROJECAO'],
      qtdProjecao: map['QTD_PROJECAO'],
    );
  }
}
