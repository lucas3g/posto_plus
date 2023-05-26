import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/grafico_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/projecao_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/vendas_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/grafico_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/projecao_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/vendas_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';

class HomeController {
  static void navigation(int index) {
    final ccusto = Modular.get<CCustoBloc>().state.selectedEmpresa;

    final List<Bloc> blocs = [
      Modular.get<VendasBloc>(),
      Modular.get<ProjecaoBloc>(),
      Modular.get<GraficoBloc>(),
    ];

    late String route = '';

    switch (index) {
      case 0:
        handleVendasProjecaoGraficoBlocs(ccusto, blocs);
        route = '../vendas/';
        break;
      case 1:
        //handleTanquesBloc(ccusto, blocs[3]);
        route = '../tanques/';
        break;
    }

    Modular.to.pushReplacementNamed(route);
  }

  static void handleVendasProjecaoGraficoBlocs(int ccusto, List<Bloc> blocs) {
    handleVendasBloc(ccusto, blocs[0]);
    handleProjecaoBloc(ccusto, blocs[1]);
    handleGraficoBloc(ccusto, blocs[2]);
  }

  static void handleVendasBloc(int ccusto, Bloc bloc) {
    if (bloc.state.filtredList.isEmpty) {
      bloc.add(GetVendasEvent());
    } else {
      bloc.add(VendasFilterEvent(ccusto: ccusto));
    }
  }

  static void handleProjecaoBloc(int ccusto, Bloc bloc) {
    if (bloc.state.filtredList.isEmpty) {
      bloc.add(GetProjecaoEvent());
    } else {
      bloc.add(ProjecaoFilterEvent(ccusto: ccusto));
    }
  }

  static void handleGraficoBloc(int ccusto, Bloc bloc) {
    if (bloc.state.filtredList.isEmpty) {
      bloc.add(GetGraficoEvent());
    } else {
      bloc.add(GraficoFilterEvent(ccusto: ccusto));
    }
  }

  static void handleTanquesBloc(int ccusto, Bloc bloc) {
    // if (bloc.state.filtredList.isEmpty) {
    //   bloc.add(GetContasEvent());
    // } else {
    //   bloc.add(ContasFilterEvent(ccusto: ccusto, diaSemanaMes: 'Dia'));
    // }
  }
}
