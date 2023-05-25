import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/grafico.dart';

class GraficoAdapter {
  static Grafico fromMap(dynamic map) {
    return Grafico(
      id: const IdVO(1),
      ccusto: int.parse(map['CCUSTO'].toString()),
      data: DateTime.parse(map['DATA'].toString()),
      total: double.tryParse(map['TOTAL'].toString()) ?? 0.00,
    );
  }
}
