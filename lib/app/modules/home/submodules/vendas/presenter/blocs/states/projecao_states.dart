import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/projecao.dart';

abstract class ProjecaoStates {
  final List<Projecao> projecao;
  final int ccusto;

  ProjecaoStates({required this.projecao, required this.ccusto});

  ProjecaoSuccessState success({List<Projecao>? projecao, int? ccusto}) {
    return ProjecaoSuccessState(
      projecao: projecao ?? this.projecao,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  ProjecaoLoadingState loading() {
    return ProjecaoLoadingState(
      projecao: projecao,
      ccusto: ccusto,
    );
  }

  ProjecaoErrorState error(String message) {
    return ProjecaoErrorState(
      message: message,
      projecao: projecao,
      ccusto: ccusto,
    );
  }

  List<Projecao> get filtredList {
    if (ccusto == 0) {
      return projecao;
    }

    if (ccusto == -1) {
      final List<Projecao> proj = [];

      proj.add(
        Projecao(
          id: const IdVO(1),
          ccusto: -1,
          vendaDiaria: projecao
              .map((e) => e.vendaDiaria.value)
              .reduce((value, element) => value + element),
          vendaSemanal: projecao
              .map((e) => e.vendaSemanal.value)
              .reduce((value, element) => value + element),
          vendaProjecao: projecao
              .map((e) => e.vendaProjecao.value)
              .reduce((value, element) => value + element),
          qtdDiaria: projecao
              .map((e) => e.qtdDiaria.value)
              .reduce((value, element) => value + element),
          qtdSemanal: projecao
              .map((e) => e.qtdSemanal.value)
              .reduce((value, element) => value + element),
          qtdProjecao: projecao
              .map((e) => e.qtdProjecao.value)
              .reduce((value, element) => value + element),
        ),
      );

      return proj;
    }

    return projecao.where((venda) => (venda.ccusto.value == ccusto)).toList();
  }
}

class ProjecaoInitialState extends ProjecaoStates {
  ProjecaoInitialState() : super(projecao: [], ccusto: 0);
}

class ProjecaoLoadingState extends ProjecaoStates {
  ProjecaoLoadingState({
    required super.projecao,
    required super.ccusto,
  });
}

class ProjecaoSuccessState extends ProjecaoStates {
  ProjecaoSuccessState({
    required super.projecao,
    required super.ccusto,
  });
}

class ProjecaoErrorState extends ProjecaoStates {
  final String message;

  ProjecaoErrorState({
    required this.message,
    required super.projecao,
    required super.ccusto,
  });
}
