import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/modules/home/presenter/controller/home_controller.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/events/tanques_events.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/states/tanques_states.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/bloc/tanques_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/tanques/presenter/widgets/tanques_grafico_widget.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';
import 'package:posto_plus/app/utils/loading_widget.dart';

class TanquesPage extends StatefulWidget {
  final TanquesBloc tanquesBloc;

  const TanquesPage({
    Key? key,
    required this.tanquesBloc,
  }) : super(key: key);

  @override
  State<TanquesPage> createState() => _TanquesPageState();
}

class _TanquesPageState extends State<TanquesPage> {
  Future<void> getAllData() async {
    await GetAllData.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: getAllData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              BlocListener<CCustoBloc, CCustoStates>(
                bloc: Modular.get<CCustoBloc>(),
                listener: (context, state) {
                  widget.tanquesBloc.add(
                    TanquesFilterEvent(ccusto: state.selectedEmpresa),
                  );
                },
                child: BlocBuilder<TanquesBloc, TanquesStates>(
                  bloc: widget.tanquesBloc,
                  buildWhen: (previous, current) {
                    return current is TanquesSuccessState;
                  },
                  builder: (context, state) {
                    if (state is! TanquesSuccessState) {
                      return const Column(
                        children: [
                          LoadingWidget(
                            size: Size(double.maxFinite, 180),
                            radius: 10,
                          ),
                          SizedBox(height: 5),
                        ],
                      );
                    }

                    final tanques = state.filtredList;

                    if (tanques.isEmpty) {
                      return const Column(
                        children: [
                          LoadingWidget(
                            size: Size(double.maxFinite, 180),
                            radius: 10,
                          ),
                          SizedBox(height: 5),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Wrap(
                          children: tanques
                              .map(
                                (tanque) => TanquesGraficoWidget(
                                  tanque: tanque,
                                  indexTanque: tanques.indexWhere(
                                    (e) => e.descricao.value.contains(
                                      tanque.descricao.value,
                                    ),
                                  ),
                                ),
                              ) // Map
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Combustível',
                                  style: context.textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Quantidade',
                                  style: context.textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: tanques
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          e.descricao.value,
                                          style: context.textTheme.bodyLarge,
                                        ),
                                      ),
                                      Text(
                                        e.volume.value.Litros(),
                                        style: context.textTheme.bodyLarge,
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
