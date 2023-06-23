import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/cr_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/events/cr_events.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/events/preco_cliente_events.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/preco_cliente_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/events/tanques_events.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/tanques_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/grafico_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/projecao_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/vendas_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/grafico_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/projecao_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/vendas_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';

class HomeController {
  static void navigation(int index, bool isNavigation) {
    final ccusto = Modular.get<CCustoBloc>().state.selectedEmpresa;

    final List<Bloc> blocs = [
      Modular.get<VendasBloc>(),
      Modular.get<ProjecaoBloc>(),
      Modular.get<GraficoBloc>(),
      Modular.get<TanquesBloc>(),
      Modular.get<CRBloc>(),
      Modular.get<PrecoClienteBloc>(),
    ];

    late String route = '';

    switch (index) {
      case 0:
        handleVendasProjecaoGraficoBlocs(ccusto, blocs, isNavigation);
        route = '../vendas/';
        break;
      case 1:
        handleTanquesBloc(ccusto, blocs[3], isNavigation);
        route = '../tanques/';
        break;
      case 2:
        handleCRBloc(ccusto, blocs[4], isNavigation);
        route = '../cr/';
        break;
      case 3:
        handlePrecoClienteBloc(ccusto, blocs[5], isNavigation);
        route = '../preco/';
        break;
    }

    if (isNavigation) {
      Modular.to.pushReplacementNamed(route);
    }
  }

  static void handleVendasProjecaoGraficoBlocs(
      int ccusto, List<Bloc> blocs, bool isNavigation) {
    handleVendasBloc(ccusto, blocs[0], isNavigation);
    handleProjecaoBloc(ccusto, blocs[1], isNavigation);
    handleGraficoBloc(ccusto, blocs[2], isNavigation);
  }

  static void handleVendasBloc(int ccusto, Bloc bloc, bool isNavigation) {
    if (bloc.state.filtredList.isEmpty || isNavigation == false) {
      bloc.add(GetVendasEvent());
    } else {
      bloc.add(VendasFilterEvent(ccusto: ccusto));
    }
  }

  static void handleProjecaoBloc(int ccusto, Bloc bloc, bool isNavigation) {
    if (bloc.state.filtredList.isEmpty || isNavigation == false) {
      bloc.add(GetProjecaoEvent());
    } else {
      bloc.add(ProjecaoFilterEvent(ccusto: ccusto));
    }
  }

  static void handleGraficoBloc(int ccusto, Bloc bloc, bool isNavigation) {
    if (bloc.state.filtredList.isEmpty || isNavigation == false) {
      bloc.add(GetGraficoEvent());
    } else {
      bloc.add(GraficoFilterEvent(ccusto: ccusto));
    }
  }

  static void handleTanquesBloc(int ccusto, Bloc bloc, bool isNavigation) {
    if (bloc.state.filtredList.isEmpty || isNavigation == false) {
      bloc.add(GetTanquesEvent());
    } else {
      bloc.add(TanquesFilterEvent(ccusto: ccusto));
    }
  }

  static void handleCRBloc(int ccusto, Bloc bloc, bool isNavigation) {
    if (bloc.state.filtredList.isEmpty || isNavigation == false) {
      bloc.add(GetCREvent());
    } else {
      bloc.add(CRFilterEvent(ccusto: ccusto, filtro: ''));
    }
  }

  static void handlePrecoClienteBloc(int ccusto, Bloc bloc, bool isNavigation) {
    if (bloc.state.filtredList.isEmpty || isNavigation == false) {
      bloc.add(GetPrecosEvent());
    } else {
      bloc.add(PrecoClienteFilterEvent(filtro: ''));
    }
  }

  static Future<bool> verifyHasInternet() async {
    final conn = await (Connectivity().checkConnectivity());

    return (((conn == ConnectivityResult.mobile) ||
            (conn == ConnectivityResult.wifi)) ||
        (conn == ConnectivityResult.ethernet));
  }
}

class GetAllData {
  static get() async {
    HomeController.navigation(0, false);
    HomeController.navigation(1, false);
    HomeController.navigation(2, false);
    HomeController.navigation(3, false);

    await Future.delayed(const Duration(seconds: 1));
  }
}
