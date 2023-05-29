import 'package:posto_plus/app/modules/home/submodules/preco_cliente/domain/entities/preco_cliente.dart';
import 'package:posto_plus/app/utils/formatters.dart';

abstract class PrecoClienteStates {
  final List<PrecoCliente> precos;
  final String filtro;

  PrecoClienteStates({required this.precos, required this.filtro});

  PrecoClienteSuccessState success(
      {List<PrecoCliente>? precos, int? ccusto, String? filtro}) {
    return PrecoClienteSuccessState(
      precos: precos ?? this.precos,
      filtro: filtro ?? this.filtro,
    );
  }

  PrecoClienteFilteredState filtered(
      {List<PrecoCliente>? precos, String? filtro}) {
    return PrecoClienteFilteredState(
      precos: precos ?? this.precos,
      filtro: filtro ?? this.filtro,
    );
  }

  PrecoClienteLoadingState loading() {
    return PrecoClienteLoadingState(
      precos: precos,
      filtro: filtro,
    );
  }

  PrecoClienteErrorState error(String message) {
    return PrecoClienteErrorState(
      message: message,
      precos: precos,
      filtro: filtro,
    );
  }

  List<PrecoCliente> get filtredList {
    if (filtro.isEmpty) {
      return precos;
    }

    return precos
        .where((e) => (e.cliente.value
                .toLowerCase()
                .contains(filtro.toLowerCase()) ||
            e.mercadoria.value.toLowerCase().contains(filtro.toLowerCase()) ||
            e.tipo.value.toLowerCase().contains(filtro.toLowerCase()) ||
            e.preco.value.reais().toLowerCase().contains(filtro.toLowerCase())))
        .toList();
  }
}

class PrecoClienteInitialState extends PrecoClienteStates {
  PrecoClienteInitialState() : super(precos: [], filtro: '');
}

class PrecoClienteLoadingState extends PrecoClienteStates {
  PrecoClienteLoadingState({
    required super.precos,
    required super.filtro,
  });
}

class PrecoClienteSuccessState extends PrecoClienteStates {
  PrecoClienteSuccessState({
    required super.precos,
    required super.filtro,
  });
}

class PrecoClienteFilteredState extends PrecoClienteStates {
  PrecoClienteFilteredState({
    required super.precos,
    required super.filtro,
  });
}

class PrecoClienteErrorState extends PrecoClienteStates {
  final String message;

  PrecoClienteErrorState({
    required this.message,
    required super.precos,
    required super.filtro,
  });
}
