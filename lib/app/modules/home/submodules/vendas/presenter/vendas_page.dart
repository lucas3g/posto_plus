// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/grafico_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/projecao_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/vendas_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/grafico_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/projecao_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/grafico_states.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/projecao_states.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/vendas_states.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/vendas_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/widgets/body_vendas_widget.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/widgets/bottom_vendas_widget.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/widgets/header_vendas_widget.dart';
import 'package:posto_plus/app/utils/my_snackbar.dart';

class VendasPage extends StatefulWidget {
  final ProjecaoBloc projecaoBloc;
  final GraficoBloc graficoBloc;
  final VendasBloc vendasBloc;

  const VendasPage({
    Key? key,
    required this.projecaoBloc,
    required this.graficoBloc,
    required this.vendasBloc,
  }) : super(key: key);

  @override
  State<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  late StreamSubscription subProjecao;
  late StreamSubscription subGrafico;
  late StreamSubscription subVendas;

  @override
  void initState() {
    super.initState();

    widget.projecaoBloc.add(GetProjecaoEvent());
    widget.graficoBloc.add(GetGraficoEvent());
    widget.vendasBloc.add(GetVendasEvent());

    subProjecao = widget.projecaoBloc.stream.listen((state) {
      if (state is ProjecaoErrorState) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });

    subGrafico = widget.graficoBloc.stream.listen((state) {
      if (state is GraficoErrorState) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });

    subVendas = widget.vendasBloc.stream.listen((state) {
      if (state is VendasErrorState) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });
  }

  @override
  void dispose() {
    //SUBS
    subProjecao.cancel();
    subGrafico.cancel();
    subVendas.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: HeaderVendasWidget(
              projecaoBloc: widget.projecaoBloc,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            flex: 4,
            child: BodyVendasWidget(
              graficoBloc: widget.graficoBloc,
            ),
          ),
          Expanded(
            flex: 4,
            child: BottomVendasWidget(
              vendasBloc: widget.vendasBloc,
            ),
          ),
        ],
      ),
    );
  }
}
