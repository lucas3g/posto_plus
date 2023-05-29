import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/usecases/get_preco_clientes_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/events/preco_cliente_events.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/states/preco_cliente_states.dart';

class PrecoClienteBloc extends Bloc<PrecoClienteEvents, PrecoClienteStates> {
  final IGetPrecoClienteUseCase getPrecoClienteUseCase;

  PrecoClienteBloc({
    required this.getPrecoClienteUseCase,
  }) : super(PrecoClienteInitialState()) {
    on<GetPrecosEvent>(getPrecos);
    on<PrecoClienteFilterEvent>(_filterPrecos);
  }

  Future getPrecos(GetPrecosEvent event, emit) async {
    final result = await getPrecoClienteUseCase();

    result.fold(
      (success) => emit(state.success(precos: success)),
      (error) => emit(state.error(error.message)),
    );
  }

  Future _filterPrecos(PrecoClienteFilterEvent event, emit) async {
    emit(state.filtered(filtro: event.filtro));
  }
}
