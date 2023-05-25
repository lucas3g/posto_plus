import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/vendas.dart';

abstract class VendasStates {
  final List<Vendas> vendas;
  final int ccusto;

  VendasStates({required this.vendas, required this.ccusto});

  VendasSuccessState success({List<Vendas>? vendas, int? ccusto}) {
    return VendasSuccessState(
      vendas: vendas ?? this.vendas,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  VendasLoadingState loading() {
    return VendasLoadingState(
      vendas: vendas,
      ccusto: ccusto,
    );
  }

  VendasErrorState error(String message) {
    return VendasErrorState(
      message: message,
      vendas: vendas,
      ccusto: ccusto,
    );
  }

  List<Vendas> get filtredList {
    if (ccusto == 0) {
      return vendas;
    }

    if (ccusto == -1) {
      final Map<DateTime, double> totalGeral = {};
      final Map<DateTime, double> qtdGeral = {};

      for (var venda in vendas) {
        if (totalGeral.containsKey(venda.data.value)) {
          totalGeral[venda.data.value] =
              totalGeral[venda.data.value]! + venda.total.value;
        } else {
          totalGeral[venda.data.value] = venda.total.value;
        }

        if (qtdGeral.containsKey(venda.data.value)) {
          qtdGeral[venda.data.value] =
              qtdGeral[venda.data.value]! + venda.qtd.value;
        } else {
          qtdGeral[venda.data.value] = venda.qtd.value;
        }
      }

      final List<Vendas> listVendas = [];

      listVendas.addAll(
        totalGeral.entries.map(
          (venda) {
            return Vendas(
              id: const IdVO(1),
              ccusto: -1,
              data: venda.key,
              qtd: 0.0,
              total: venda.value,
            );
          },
        ),
      );

      for (var venda in listVendas) {
        venda.setQTD(
          qtdGeral.entries.firstWhere((e) => e.key == venda.data.value).value,
        );
      }

      return listVendas;
    }

    return vendas.where((venda) => (venda.ccusto.value == ccusto)).toList();
  }
}

class VendasInitialState extends VendasStates {
  VendasInitialState() : super(vendas: [], ccusto: 0);
}

class VendasLoadingState extends VendasStates {
  VendasLoadingState({
    required super.vendas,
    required super.ccusto,
  });
}

class VendasSuccessState extends VendasStates {
  VendasSuccessState({
    required super.vendas,
    required super.ccusto,
  });
}

class VendasErrorState extends VendasStates {
  final String message;

  VendasErrorState({
    required this.message,
    required super.vendas,
    required super.ccusto,
  });
}
