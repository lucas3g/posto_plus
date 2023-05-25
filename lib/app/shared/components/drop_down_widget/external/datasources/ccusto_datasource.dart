import 'dart:convert';

import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/client_http/client_http_interface.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/infra/datasources/ccusto_datasource.dart';

class CCustoDataSource implements ICCustoDataSource {
  final IClientHttp clientHttp;

  CCustoDataSource({
    required this.clientHttp,
  });

  @override
  Future<List> getCCustos() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/locais/locais');

    if (result.statusCode != 200) {
      throw const MyException(message: 'erro ao buscar centro de custo');
    }

    return jsonDecode(result.data);
  }
}
