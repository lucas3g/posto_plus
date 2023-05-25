import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/entities/ccusto_entity.dart';

class CCustoAdapter {
  static CCusto fromMap(dynamic map) {
    return CCusto(
      id: const IdVO(1),
      descricao: map['DESCRICAO'],
      ccusto: map['ID'],
    );
  }
}
