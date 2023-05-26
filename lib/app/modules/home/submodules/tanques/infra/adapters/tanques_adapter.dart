import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/entities/tanques.dart';

class TanquesAdapter {
  static Tanques fromMap(dynamic map) {
    return Tanques(
      id: const IdVO(1),
      ccusto: int.parse(map['CCUSTO'].toString()),
      descricao: map['DESCRICAO'],
      descResumida: map['DESCRESUMIDA'],
      capacidade: int.parse(map['CAPACIDADE'].toString()),
      tanque: int.parse(map['TANQUE'].toString()),
      volume: double.parse(map['VOLUME'].toString()),
    );
  }
}
