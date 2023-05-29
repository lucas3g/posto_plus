import 'dart:convert';

import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/client_http/client_http_interface.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/infra/datasources/preco_cliente_datasource.dart';

class PrecoClienteDatasource implements IPrecoClienteDatasource {
  final IClientHttp clientHttp;

  PrecoClienteDatasource({
    required this.clientHttp,
  });

  @override
  Future<List> getPrecos() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/$urlPreco');

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao buscar Preco por Cliente');
    }

    return List.from(jsonDecode(result.data));
  }
}
