import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/vendas_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/vendas_states.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/vendas_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';
import 'package:posto_plus/app/utils/loading_widget.dart';

class BottomVendasWidget extends StatefulWidget {
  final VendasBloc vendasBloc;
  const BottomVendasWidget({
    Key? key,
    required this.vendasBloc,
  }) : super(key: key);

  @override
  State<BottomVendasWidget> createState() => _BottomVendasWidgetState();
}

class _BottomVendasWidgetState extends State<BottomVendasWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 'Total de Vendas Diária'.length.toDouble() * 9,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.myTheme.onBackground,
              ),
            ),
          ),
          child: Text(
            'Total de Vendas Diária',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BlocListener<CCustoBloc, CCustoStates>(
              bloc: Modular.get<CCustoBloc>(),
              listener: (context, state) {
                widget.vendasBloc.add(
                  VendasFilterEvent(ccusto: state.selectedEmpresa),
                );
              },
              child: BlocBuilder<VendasBloc, VendasStates>(
                  bloc: widget.vendasBloc,
                  buildWhen: (previous, current) {
                    return current is VendasSuccessState;
                  },
                  builder: (context, state) {
                    if (state is! VendasSuccessState) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return const LoadingWidget(
                            size: Size(double.maxFinite, 40),
                            radius: 10,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: 5,
                      );
                    }

                    final vendas = state.filtredList;

                    if (vendas.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma venda efetuada hoje.'),
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(vendas[index].data.value.DiaMes()),
                              Text('${vendas[index].qtd.value.Litros()} LT'),
                              Text(vendas[index].total.value.reais()),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: vendas.length,
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
