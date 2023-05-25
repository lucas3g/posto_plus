import 'package:posto_plus/app/core_module/types/entity.dart';
import 'package:posto_plus/app/core_module/vos/date_time_vo.dart';
import 'package:posto_plus/app/core_module/vos/double_vo.dart';
import 'package:posto_plus/app/core_module/vos/id_vo.dart';

class Vendas extends Entity {
  final IdVO _ccusto;
  final DateTimeVO _data;
  DoubleVO _qtd;
  final DoubleVO _total;

  IdVO get ccusto => _ccusto;
  DateTimeVO get data => _data;
  DoubleVO get qtd => _qtd;
  void setQTD(double value) => _qtd = DoubleVO(value);
  DoubleVO get total => _total;

  Vendas({
    required super.id,
    required int ccusto,
    required DateTime data,
    required double qtd,
    required double total,
  })  : _ccusto = IdVO(ccusto),
        _data = DateTimeVO(data),
        _qtd = DoubleVO(qtd),
        _total = DoubleVO(total);
}
