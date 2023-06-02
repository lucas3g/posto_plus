import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/domain/entities/grafico.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/events/grafico_events.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/grafico_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/states/grafico_states.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';
import 'package:posto_plus/app/utils/loading_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughNutGraficoVendasWidget extends StatefulWidget {
  final GraficoBloc graficoBloc;

  const DoughNutGraficoVendasWidget({
    Key? key,
    required this.graficoBloc,
  }) : super(key: key);

  @override
  State<DoughNutGraficoVendasWidget> createState() =>
      _DoughNutGraficoVendasWidgetState();
}

class _DoughNutGraficoVendasWidgetState
    extends State<DoughNutGraficoVendasWidget> {
  late List<VendasSemanais> listaNova = [];

  montaGrafico(List<Grafico> vendasGrafico) {
    listaNova.clear();

    listaNova.addAll(
      vendasGrafico.map(
        (e) => VendasSemanais(e.data.value, e.total.value),
      ),
    );

    listaNova.sort((a, b) => a.dia.isAfter(b.dia) ? 1 : -1);

    return listaNova;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CCustoBloc, CCustoStates>(
      bloc: Modular.get<CCustoBloc>(),
      listener: (context, state) {
        widget.graficoBloc.add(
          GraficoFilterEvent(ccusto: state.selectedEmpresa),
        );
      },
      child: BlocBuilder<GraficoBloc, GraficoStates>(
          bloc: widget.graficoBloc,
          buildWhen: (previous, current) {
            return current is GraficoSuccessState;
          },
          builder: (context, state) {
            if (state is! GraficoSuccessState) {
              return Column(
                children: const [
                  Expanded(
                    child: LoadingWidget(
                      size: Size(double.maxFinite, 40),
                      radius: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              );
            }

            final vendas = state.filtredList;

            if (vendas.isEmpty) {
              return Column(
                children: const [
                  Expanded(
                    child: LoadingWidget(
                      size: Size(double.maxFinite, 40),
                      radius: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              );
            }

            return SfCircularChart(
              margin: EdgeInsets.zero,
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: Colors.white,
                canShowMarker: false,
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTooltipRender: (TooltipArgs args) {
                final DateTime data = listaNova[args.pointIndex as int].dia;
                final double valor = listaNova[args.pointIndex as int].valor;
                args.header = 'Dia - ${data.DiaMes()}';
                args.text = valor.reais();
              },
              legend: Legend(isVisible: true),
              series: <DoughnutSeries<VendasSemanais, String>>[
                DoughnutSeries<VendasSemanais, String>(
                  dataSource: montaGrafico(vendas),
                  xValueMapper: (VendasSemanais vendas, _) => vendas.dia.Dia(),
                  yValueMapper: (VendasSemanais vendas, _) => vendas.valor,
                  pointColorMapper: (datum, index) => colorsGrafico[index],
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  dataLabelMapper: (datum, index) {
                    return datum.dia.Dia();
                  },
                )
              ],
              title: ChartTitle(
                text: '<< Vendas dos últimos 7 dias',
                textStyle: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ThemeModeController.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            );
          }),
    );
  }
}

class VendasSemanais {
  VendasSemanais(this.dia, this.valor);
  final DateTime dia;
  final double valor;
}
