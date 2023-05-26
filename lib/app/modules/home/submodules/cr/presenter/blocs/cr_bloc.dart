import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/usecases/get_resumo_cr_usecase.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/events/cr_events.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/states/cr_states.dart';

class CRBloc extends Bloc<CREvents, CRStates> {
  final IGetResumoCRUseCase getResumoCRUseCase;

  CRBloc({
    required this.getResumoCRUseCase,
  }) : super(CRInitialState()) {
    on<GetCREvent>(_getResumoCR);
    on<CRFilterEvent>(_filterCR);
  }

  Future _getResumoCR(GetCREvent event, emit) async {
    emit(state.loading());
    final result = await getResumoCRUseCase();

    result.fold(
      (success) => emit(state.success(crs: success)),
      (error) => emit(state.error(error.message)),
    );
  }

  Future _filterCR(CRFilterEvent event, emit) async {
    emit(state.filtered(ccusto: event.ccusto, filtro: event.filtro));
  }
}
