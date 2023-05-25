// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/client_http/client_http_interface.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/infra/datasources/vendas_datasource.dart';

class VendasDatasource implements IVendasDatasource {
  final IClientHttp clientHttp;

  VendasDatasource({
    required this.clientHttp,
  });

  @override
  Future<List> getProjecao() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/$urlProjecao');

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao buscar projecao');
    }

    return List.from(jsonDecode(result.data));
  }

  @override
  Future<List> getGrafico() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/$urlGrafico');

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao buscar vendas do grafico');
    }

    return List.from(jsonDecode(result.data));
  }

  @override
  Future<List> getVendas() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/$urlVendas');

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao buscar vendas');
    }

    return List.from(jsonDecode(result.data));
  }
}
