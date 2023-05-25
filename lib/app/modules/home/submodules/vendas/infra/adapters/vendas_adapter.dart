import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/vendas.dart';

class VendasAdapter {
  static Vendas fromMap(dynamic map) {
    return Vendas(
      id: const IdVO(1),
      ccusto: int.parse(map['CCUSTO'].toString()),
      data: DateTime.parse(map['DATA'].toString()),
      qtd: double.tryParse(map['QTD'].toString()) ?? 0.0,
      total: double.tryParse(map['TOTAL'].toString()) ?? 0.0,
    );
  }
}
