import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/usecases/get_ccustos_usecase.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/events/ccusto_event.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';

class CCustoBloc extends Bloc<CCustoEvents, CCustoStates> {
  final GetCCustoUseCase getCCustoUseCase;

  CCustoBloc({required this.getCCustoUseCase}) : super(CCustoInitialState()) {
    on<GetCCustoEvent>(_getCCustos);
    on<ChangeCCustoEvent>(_changeCCusto);
  }

  Future _getCCustos(GetCCustoEvent event, emit) async {
    emit(state.loading());
    final result = await getCCustoUseCase();

    result.fold(
      (success) => emit(
        state.success(
          ccustos: success,
          selectedEmpresa: success[0].ccusto.value,
        ),
      ),
      (error) => emit(state.error(error.message)),
    );
  }

  void _changeCCusto(ChangeCCustoEvent event, emit) {
    emit(state.success(selectedEmpresa: event.ccusto));
  }
}
