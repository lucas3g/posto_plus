import 'dart:convert';

import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/client_http/client_http_interface.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/infra/datasources/tanques_datasource.dart';

class TanquesDatasource implements ITanquesDatasource {
  final IClientHttp clientHttp;

  TanquesDatasource({
    required this.clientHttp,
  });

  @override
  Future<List> getTanques() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/$urlTanques');

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao buscar tanques');
    }

    return List.from(jsonDecode(result.data));
  }
}
