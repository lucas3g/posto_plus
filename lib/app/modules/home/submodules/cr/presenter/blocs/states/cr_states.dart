import 'package:posto_plus/app/modules/home/submodules/cr/domain/entities/cr.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/infra/adapters/cr_adapter.dart';
import 'package:posto_plus/app/utils/formatters.dart';

abstract class CRStates {
  final List<CR> crs;
  final int ccusto;
  final String filtro;

  CRStates({required this.crs, required this.ccusto, required this.filtro});

  CRSuccessState success({List<CR>? crs, int? ccusto, String? filtro}) {
    return CRSuccessState(
      crs: crs ?? this.crs,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  CRFilteredState filtered({List<CR>? crs, int? ccusto, String? filtro}) {
    return CRFilteredState(
      crs: crs ?? this.crs,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  CRLoadingState loading() {
    return CRLoadingState(
      crs: crs,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  CRErrorState error(String message) {
    return CRErrorState(
      message: message,
      crs: crs,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  List<CR> get filtredList {
    if (ccusto == 0 && filtro.isEmpty) {
      return crs;
    }

    if (ccusto > 0 && filtro.isEmpty) {
      return crs
          .where(
            (cr) => (cr.ccusto.value == ccusto),
          )
          .toList();
    }

    if (ccusto == -1) {
      List<Map<String, dynamic>>? listCR = [];

      for (var cr in crs) {
        if (listCR.map((e) => e['NOME_CLIENTE']).contains(cr.nome.value)) {
          listCR[listCR.indexWhere((e) => e['NOME_CLIENTE'] == cr.nome.value)]
              ["SALDO_ATUAL"] += cr.valor.value;
        } else {
          listCR.add(
            {
              "LOCAL": cr.ccusto.value,
              "NOME_CLIENTE": cr.nome.value,
              "SALDO_ATUAL": cr.valor.value,
            },
          );
        }
      }

      final listCRFinal = listCR.map(CRAdapter.fromMap).toList();

      if (filtro.isNotEmpty) {
        return listCRFinal
            .where((cr) => (cr.nome.value
                .toLowerCase()
                .removeAcentos()
                .contains(filtro.toLowerCase().removeAcentos())))
            .toList();
      }

      return listCRFinal;
    }

    return crs
        .where(
          (cr) => (cr.ccusto.value == ccusto &&
              cr.nome.value
                  .toLowerCase()
                  .removeAcentos()
                  .contains(filtro.toLowerCase().removeAcentos())),
        )
        .toList();
  }

  double get saldoCR {
    return filtredList
        .map((cr) => cr.valor.value)
        .reduce((value, element) => value + element)
        .toDouble();
  }
}

class CRInitialState extends CRStates {
  CRInitialState() : super(crs: [], ccusto: 0, filtro: '');
}

class CRLoadingState extends CRStates {
  CRLoadingState({
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}

class CRSuccessState extends CRStates {
  CRSuccessState({
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}

class CRFilteredState extends CRStates {
  CRFilteredState({
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}

class CRErrorState extends CRStates {
  final String message;

  CRErrorState({
    required this.message,
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}
