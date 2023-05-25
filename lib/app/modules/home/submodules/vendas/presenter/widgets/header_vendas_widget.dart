import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/projecao_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/projecao_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/projecao_states.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/widgets/labels_projecao_widget.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/loading_widget.dart';

class HeaderVendasWidget extends StatefulWidget {
  final ProjecaoBloc projecaoBloc;
  const HeaderVendasWidget({
    Key? key,
    required this.projecaoBloc,
  }) : super(key: key);

  @override
  State<HeaderVendasWidget> createState() => _HeaderVendasWidgetState();
}

class _HeaderVendasWidgetState extends State<HeaderVendasWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocListener<CCustoBloc, CCustoStates>(
            bloc: Modular.get<CCustoBloc>(),
            listener: (context, state) {
              widget.projecaoBloc.add(
                ProjecaoFilterEvent(ccusto: state.selectedEmpresa),
              );
            },
            child: BlocBuilder<ProjecaoBloc, ProjecaoStates>(
                bloc: widget.projecaoBloc,
                buildWhen: (previous, current) {
                  return current is ProjecaoSuccessState;
                },
                builder: (context, state) {
                  if (state is! ProjecaoSuccessState) {
                    return Column(
                      children: [
                        LoadingWidget(
                          size: Size(context.screenWidth * .88, 40),
                          radius: 10,
                        ),
                      ],
                    );
                  }

                  final projecao = state.filtredList;

                  if (projecao.isEmpty) {
                    return Column(
                      children: [
                        LoadingWidget(
                          size: Size(context.screenWidth * .88, 40),
                          radius: 10,
                        ),
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LabelsProjecaoWidget(
                        title: 'Hoje',
                        litros: projecao[0].qtdDiaria.value,
                        venda: projecao[0].vendaDiaria.value,
                      ),
                      const SizedBox(width: 10),
                      LabelsProjecaoWidget(
                        title: 'Semanal',
                        litros: projecao[0].qtdSemanal.value,
                        venda: projecao[0].vendaSemanal.value,
                      ),
                      const SizedBox(width: 10),
                      LabelsProjecaoWidget(
                        title: 'Mensal',
                        litros: projecao[0].qtdProjecao.value,
                        venda: projecao[0].vendaProjecao.value,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
