import 'package:flutter/material.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/domain/entities/tanques.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TanquesGraficoWidget extends StatelessWidget {
  final Tanques tanque;
  final int indexTanque;

  TanquesGraficoWidget({
    Key? key,
    required this.tanque,
    required this.indexTanque,
  }) : super(key: key);

  final List<Color> colors = [
    const Color(0xFFba0000),
    const Color(0xFFff5900),
    const Color(0xFF54ba00),
    const Color(0xFF00b1ba),
    const Color(0xFF0019ba),
    const Color(0xFFb400ba),
    const Color(0xFFb7ba00),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: context.screenWidth * .4722,
          height: 180,
          child: SfCircularChart(
            margin: EdgeInsets.zero,
            tooltipBehavior: TooltipBehavior(
              tooltipPosition: TooltipPosition.pointer,
              enable: true,
              color: Colors.white,
              textStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              shadowColor: colors[indexTanque],
            ),
            onTooltipRender: (TooltipArgs args) {
              args.header =
                  'Capacidade: ${tanque.capacidade.value.LitrosInt()}';
              args.text =
                  'Usado: ${tanque.volume.value.Litros()}\nResta: ${(tanque.capacidade.value - tanque.volume.value).Litros()}';
            },
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                height: '100%',
                width: '100%',
                widget: PhysicalModel(
                  shape: BoxShape.circle,
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(230, 230, 230, 1),
                  child: Container(),
                ),
              ),
              CircularChartAnnotation(
                widget: Text(
                  '${tanque.volume.value.Litros()} LT\n(${((tanque.volume.value / tanque.capacidade.value) * 100).Porcentagem()}% )',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors[indexTanque],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CircularChartAnnotation(
                widget: Container(
                  margin: const EdgeInsets.only(top: 160),
                  child: Column(
                    children: [
                      Text(
                        tanque.descResumida.value,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cap. ${tanque.capacidade.value.LitrosInt()} LT',
                      ),
                      Text(
                        'Resta: ${(tanque.capacidade.value - tanque.volume.value).Litros()} LT',
                      ),
                    ],
                  ),
                ),
              ),
            ],
            series: getSeriesTanques(tanque: tanque, index: indexTanque),
          ),
        ),
        const Text(''),
        const Text(''),
        const Text(''),
      ],
    );
  }

  List<DoughnutSeries<TanqueData, String>> getSeriesTanques(
      {required Tanques tanque, required int index}) {
    final List<TanqueData> chartData = [
      TanqueData(
        x: 'A',
        y: tanque.volume.value.toDouble(),
        pointColor: index < colors.length ? colors[index] : colors[0],
      ),
      TanqueData(
        x: 'B',
        y: tanque.volume.value > tanque.capacidade.value
            ? 0
            : tanque.capacidade.value.toDouble() -
                tanque.volume.value.toDouble(),
        pointColor: const Color.fromRGBO(230, 230, 230, 1),
      )
    ];

    return <DoughnutSeries<TanqueData, String>>[
      DoughnutSeries<TanqueData, String>(
        dataSource: chartData,
        animationDuration: 700,
        xValueMapper: (TanqueData data, _) => data.x,
        yValueMapper: (TanqueData data, _) => data.y,
        pointColorMapper: (TanqueData data, _) => data.pointColor,
      )
    ];
  }
}

class TanqueData {
  TanqueData({required this.x, required this.y, required this.pointColor});
  final String x;
  final double y;
  final Color pointColor;
}
