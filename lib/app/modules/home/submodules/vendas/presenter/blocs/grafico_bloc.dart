import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/usecases/get_vendas_grafico_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/grafico_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/grafico_states.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';

class GraficoBloc extends Bloc<GraficoEvents, GraficoStates> {
  final IGetVendasGraficoUseCase getVendasGraficoUseCase;

  GraficoBloc({
    required this.getVendasGraficoUseCase,
  }) : super(GraficoInitialState()) {
    on<GetGraficoEvent>(_getVendasGrafico);
    on<GraficoFilterEvent>(_graficoFilter);
  }

  Future _getVendasGrafico(GetGraficoEvent event, emit) async {
    emit(state.loading());
    final result = await getVendasGraficoUseCase();

    result.fold(
      (success) {
        _graficoFilter(
          GraficoFilterEvent(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(grafico: success));
      },
      (error) => emit(state.error(error.message)),
    );
  }

  Future _graficoFilter(GraficoFilterEvent event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
