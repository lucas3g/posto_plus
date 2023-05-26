import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/entities/cr.dart';

class CRAdapter {
  static CR fromMap(dynamic map) {
    return CR(
      id: const IdVO(1),
      ccusto: int.parse(map['LOCAL'].toString()),
      nome: map['NOME_CLIENTE'],
      valor: double.tryParse(map['SALDO_ATUAL'].toString()) ?? 0.00,
    );
  }
}
