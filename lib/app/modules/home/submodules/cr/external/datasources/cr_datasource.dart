import 'dart:convert';

import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/client_http/client_http_interface.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/infra/datasources/cr_datasource.dart';

class CRDataSource implements ICRDataSource {
  final IClientHttp clientHttp;

  CRDataSource({
    required this.clientHttp,
  });

  @override
  Future<List> getResumoCR() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/$urlCR');

    if (result.statusCode != 200) {
      throw const MyException(
          message: 'Erro ao buscar Resumo do Contas a Receber');
    }

    return List.from(jsonDecode(result.data));
  }
}
