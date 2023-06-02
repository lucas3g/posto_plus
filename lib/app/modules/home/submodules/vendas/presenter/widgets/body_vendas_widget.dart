import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/blocs/grafico_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/widgets/graficos/column_grafico_vendas_widget.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/widgets/graficos/doughnut_grafico_vendas_widget.dart';
import 'package:posto_plus/app/modules/home/submodules/vendas/presenter/widgets/graficos/line_grafico_vendas_widget.dart';

class BodyVendasWidget extends StatefulWidget {
  final GraficoBloc graficoBloc;

  const BodyVendasWidget({
    Key? key,
    required this.graficoBloc,
  }) : super(key: key);

  @override
  State<BodyVendasWidget> createState() => _BodyVendasWidgetState();
}

class _BodyVendasWidgetState extends State<BodyVendasWidget> {
  late int count = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        LineGraficoVendasWidget(
          graficoBloc: widget.graficoBloc,
        ).animate(
          onComplete: (controller) async {
            if (count == 0) {
              await controller.reverse();
              await controller.forward();
              count++;
              setState(() {});
            }

            if (count == 1) {
              controller.reverse();
              count = -1;
              setState(() {});
            }
          },
          onPlay: (controller) {
            if (count == -1) {
              controller.stop();
            }
          },
        ).moveX(
          begin: 0,
          end: 10,
          curve: Curves.easeIn,
          delay: const Duration(milliseconds: 300),
        ),
        ColumnGraficoVendasWidget(
          graficoBloc: widget.graficoBloc,
        ),
        DoughNutGraficoVendasWidget(
          graficoBloc: widget.graficoBloc,
        ),
      ],
    );
  }
}
