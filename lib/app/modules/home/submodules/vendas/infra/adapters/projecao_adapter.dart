import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/projecao.dart';

class ProjecaoAdapter {
  static Projecao fromMap(dynamic map) {
    return Projecao(
      id: const IdVO(1),
      ccusto: int.parse(map['CCUSTO'].toString()),
      vendaDiaria: double.parse(map['VENDA_DIARIA'].toString()),
      qtdDiaria: double.parse(map['QTD_DIARIA'].toString()),
      vendaSemanal: double.parse(map['VENDA_SEMANAL'].toString()),
      qtdSemanal: double.parse(map['QTD_SEMANAL'].toString()),
      vendaProjecao: double.parse(map['VENDA_MES'].toString()),
      qtdProjecao: double.parse(map['QTD_MES'].toString()),
    );
  }
}
