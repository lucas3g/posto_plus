import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:posto_plus/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:posto_plus/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:result_dart/functions.dart';

import '../../../../../mocks/mocks.dart';

class IAuthDatasourceMock extends Mock implements IAuthDatasource {}

void main() {
  late IAuthDatasource datasource;
  late IAuthRepository repository;

  setUp(() {
    datasource = IAuthDatasourceMock();
    repository = AuthRepository(datasource);
  });

  test('deve retornar uma entidade de User', () async {
    when(
      () => datasource.login(userMock),
    ).thenAnswer(
      (_) async => {
        "CNPJ": "97.305.890/0001-81",
        "USUARIO": "ADM",
        "SENHA": "EL",
        "NOME": "SUPORTE - EL",
        "APP_POSTO": "S",
      },
    );

    final result = await repository.login(userMock);

    expect(result.fold(id, id), isA<User>());
  });
}
