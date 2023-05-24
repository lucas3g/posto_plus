import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/modules/auth/domain/usecases/login_user_usecase.dart';
import 'package:posto_plus/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:posto_plus/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final ILoginUserUseCase loginUserUseCase;

  AuthBloc({
    required this.loginUserUseCase,
  }) : super(InitialAuth()) {
    on<LoginAuthEvent>(login);
  }

  Future login(LoginAuthEvent event, emit) async {
    emit(state.loading());

    final result = await loginUserUseCase(event.user);

    result.fold(
      (success) => emit(state.success(success)),
      (failure) => emit(state.error(failure.message)),
    );
  }
}
