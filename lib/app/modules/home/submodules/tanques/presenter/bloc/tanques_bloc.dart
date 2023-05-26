import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/usecases/get_tanques_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/events/tanques_events.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/states/tanques_states.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';

class TanquesBloc extends Bloc<TanquesEvents, TanquesStates> {
  final IGetTanquesUseCase getTanquesUseCase;

  TanquesBloc({
    required this.getTanquesUseCase,
  }) : super(TanquesInitialState()) {
    on<GetTanquesEvent>(_getTanques);
    on<TanquesFilterEvent>(_tanquesFilter);
  }

  Future _getTanques(GetTanquesEvent event, emit) async {
    final result = await getTanquesUseCase();

    result.fold(
      (success) {
        _tanquesFilter(
          TanquesFilterEvent(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(tanques: success));
      },
      (error) => emit(state.error(error.message)),
    );
  }

  Future _tanquesFilter(TanquesFilterEvent event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
