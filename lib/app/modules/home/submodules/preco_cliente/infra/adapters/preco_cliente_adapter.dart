import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/entities/preco_cliente.dart';

class PrecoClienteAdapter {
  static PrecoCliente fromMap(dynamic map) {
    return PrecoCliente(
      id: const IdVO(1),
      cliente: map['CLIENTE'],
      mercadoria: map['MERCADORIA'],
      preco: double.parse(map['PRECO'].toString()),
      tipo: map['TIPO'],
    );
  }
}
