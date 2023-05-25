import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/grafico.dart';

abstract class GraficoStates {
  final List<Grafico> grafico;
  final int ccusto;

  GraficoStates({required this.grafico, required this.ccusto});

  GraficoSuccessState success({List<Grafico>? grafico, int? ccusto}) {
    return GraficoSuccessState(
      grafico: grafico ?? this.grafico,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  GraficoLoadingState loading() {
    return GraficoLoadingState(
      grafico: grafico,
      ccusto: ccusto,
    );
  }

  GraficoErrorState error(String message) {
    return GraficoErrorState(
      message: message,
      grafico: grafico,
      ccusto: ccusto,
    );
  }

  List<Grafico> get filtredList {
    if (ccusto == 0) {
      return grafico;
    }

    if (ccusto == -1) {
      final Map<DateTime, double> totalGeral = {};

      for (var graf in grafico) {
        if (totalGeral.containsKey(graf.data.value)) {
          totalGeral[graf.data.value] =
              totalGeral[graf.data.value]! + graf.total.value;
        } else {
          totalGeral[graf.data.value] = graf.total.value;
        }
      }

      final List<Grafico> listGrafico = [];

      listGrafico.addAll(
        totalGeral.entries.map(
          (venda) {
            return Grafico(
              id: const IdVO(1),
              ccusto: -1,
              data: venda.key,
              total: venda.value,
            );
          },
        ),
      );

      return listGrafico;
    }

    return grafico.where((venda) => (venda.ccusto.value == ccusto)).toList();
  }
}

class GraficoInitialState extends GraficoStates {
  GraficoInitialState() : super(grafico: [], ccusto: 0);
}

class GraficoLoadingState extends GraficoStates {
  GraficoLoadingState({
    required super.grafico,
    required super.ccusto,
  });
}

class GraficoSuccessState extends GraficoStates {
  GraficoSuccessState({
    required super.grafico,
    required super.ccusto,
  });
}

class GraficoErrorState extends GraficoStates {
  final String message;

  GraficoErrorState({
    required this.message,
    required super.grafico,
    required super.ccusto,
  });
}
