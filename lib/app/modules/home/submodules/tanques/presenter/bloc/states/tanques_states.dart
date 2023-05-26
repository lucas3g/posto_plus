import 'package:posto_plus/app/core_module/vos/id_vo.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/entities/tanques.dart';

abstract class TanquesStates {
  final List<Tanques> tanques;
  final int ccusto;

  TanquesStates({required this.tanques, required this.ccusto});

  TanquesSuccessState success({List<Tanques>? tanques, int? ccusto}) {
    return TanquesSuccessState(
      tanques: tanques ?? this.tanques,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  TanquesLoadingState loading() {
    return TanquesLoadingState(
      tanques: tanques,
      ccusto: ccusto,
    );
  }

  TanquesErrorState error(String message) {
    return TanquesErrorState(
      message: message,
      tanques: tanques,
      ccusto: ccusto,
    );
  }

  List<Tanques> get filtredList {
    if (ccusto == 0) {
      return tanques;
    }

    if (ccusto == -1) {
      final Map<String, int> capacidadeGeral = {};
      final Map<String, double> volumeGeral = {};
      final Map<String, String> descResumidaGeral = {};

      for (var tanque in tanques) {
        if (capacidadeGeral.containsKey(tanque.descricao.value)) {
          capacidadeGeral[tanque.descricao.value] =
              capacidadeGeral[tanque.descricao.value]! +
                  tanque.capacidade.value;
        } else {
          capacidadeGeral[tanque.descricao.value] = tanque.capacidade.value;
        }

        if (volumeGeral.containsKey(tanque.descricao.value)) {
          volumeGeral[tanque.descricao.value] =
              volumeGeral[tanque.descricao.value]! + tanque.volume.value;
        } else {
          volumeGeral[tanque.descricao.value] = tanque.volume.value;
        }

        if (descResumidaGeral.containsKey(tanque.descricao.value)) {
          descResumidaGeral[tanque.descricao.value] = tanque.descResumida.value;
        } else {
          descResumidaGeral[tanque.descricao.value] = tanque.descResumida.value;
        }
      }

      final List<Tanques> listTanques = [];

      listTanques.addAll(
        capacidadeGeral.entries.map(
          (venda) {
            return Tanques(
              id: const IdVO(1),
              ccusto: -1,
              capacidade: venda.value,
              descricao: venda.key,
              descResumida: '',
              tanque: 1,
              volume: 0,
            );
          },
        ),
      );

      for (var tanque in listTanques) {
        tanque.setVolume(
          volumeGeral.entries
              .firstWhere((e) => e.key == tanque.descricao.value)
              .value,
        );

        tanque.setDescResumida(
          descResumidaGeral.entries
              .firstWhere((e) => e.key == tanque.descricao.value)
              .value,
        );
      }

      return listTanques;
    }

    return tanques.where((venda) => (venda.ccusto.value == ccusto)).toList();
  }
}

class TanquesInitialState extends TanquesStates {
  TanquesInitialState() : super(tanques: [], ccusto: 0);
}

class TanquesLoadingState extends TanquesStates {
  TanquesLoadingState({
    required super.tanques,
    required super.ccusto,
  });
}

class TanquesSuccessState extends TanquesStates {
  TanquesSuccessState({
    required super.tanques,
    required super.ccusto,
  });
}

class TanquesErrorState extends TanquesStates {
  final String message;

  TanquesErrorState({
    required this.message,
    required super.tanques,
    required super.ccusto,
  });
}
