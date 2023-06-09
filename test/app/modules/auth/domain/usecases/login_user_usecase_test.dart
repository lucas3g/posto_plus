import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:posto_plus/app/modules/auth/domain/usecases/login_user_usecase.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../mocks/mocks.dart';

class IAuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository repository;
  late ILoginUserUseCase useCase;

  setUp(() {
    repository = IAuthRepositoryMock();
    useCase = LoginUserUseCase(repository);
  });

  test('deve retornar uma entidade de User', () async {
    when(
      () => repository.login(userMock),
    ).thenAnswer((_) async => userMock.toSuccess());

    final result = await useCase(userMock);

    expect(result.fold(id, id), isA<User>());
  });
}
