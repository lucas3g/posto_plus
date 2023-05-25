import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/usecases/get_projecao_vendas_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/projecao_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/projecao_states.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';

class ProjecaoBloc extends Bloc<ProjecaoEvents, ProjecaoStates> {
  final IGetProjecaoVendasUseCase getProjecaoUseCase;

  ProjecaoBloc({required this.getProjecaoUseCase})
      : super(ProjecaoInitialState()) {
    on<GetProjecaoEvent>(_getProjecao);
    on<ProjecaoFilterEvent>(_projecaoFilter);
  }

  Future _getProjecao(GetProjecaoEvent event, emit) async {
    emit(state.loading());
    final result = await getProjecaoUseCase();

    result.fold(
      (success) {
        _projecaoFilter(
          ProjecaoFilterEvent(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(projecao: success));
      },
      (r) {
        emit(state.error(r.message));
      },
    );
  }

  Future _projecaoFilter(ProjecaoFilterEvent event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
