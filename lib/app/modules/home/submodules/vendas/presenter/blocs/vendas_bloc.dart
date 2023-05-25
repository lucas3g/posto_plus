import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/vendas_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/vendas_states.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';

class VendasBloc extends Bloc<VendasEvents, VendasStates> {
  final IGetVendasUseCase getVendasUseCase;

  VendasBloc({
    required this.getVendasUseCase,
  }) : super(VendasInitialState()) {
    on<GetVendasEvent>(_getVendas);
    on<VendasFilterEvent>(_vendasFilter);
  }

  Future _getVendas(GetVendasEvent event, emit) async {
    emit(state.loading());
    final result = await getVendasUseCase();

    result.fold(
      (success) {
        _vendasFilter(
          VendasFilterEvent(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(vendas: success));
      },
      (r) => emit(state.error(r.message)),
    );
  }

  Future _vendasFilter(VendasFilterEvent event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
