import 'package:posto_plus/app/core_module/types/entity.dart';
import 'package:posto_plus/app/core_module/vos/double_vo.dart';
import 'package:posto_plus/app/core_module/vos/text_vo.dart';

class PrecoCliente extends Entity {
  final TextVO _cliente;
  final TextVO _mercadoria;
  final DoubleVO _preco;
  final TextVO _tipo;

  TextVO get cliente => _cliente;
  TextVO get mercadoria => _mercadoria;
  DoubleVO get preco => _preco;
  TextVO get tipo => _tipo;

  PrecoCliente({
    required super.id,
    required String cliente,
    required String mercadoria,
    required double preco,
    required String tipo,
  })  : _cliente = TextVO(cliente),
        _mercadoria = TextVO(mercadoria),
        _preco = DoubleVO(preco),
        _tipo = TextVO(tipo);
}
