import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/cr_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/events/cr_events.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/blocs/states/cr_states.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/presenter/widgets/my_list_tile_cr_widget.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:posto_plus/app/shared/components/my_input_widget.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';
import 'package:posto_plus/app/utils/loading_widget.dart';
import 'package:posto_plus/app/utils/my_snackbar.dart';

class CRPage extends StatefulWidget {
  final CRBloc crBloc;
  const CRPage({
    Key? key,
    required this.crBloc,
  }) : super(key: key);

  @override
  State<CRPage> createState() => _CRPageState();
}

class _CRPageState extends State<CRPage> {
  final fPesquisa = FocusNode();
  final pesquisaController = TextEditingController();
  final gkPesquisa = GlobalKey<FormState>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    // widget.crBloc.add(GetCREvent());

    sub = widget.crBloc.stream.listen((state) {
      if (state is CRErrorState) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }

      if (state is CRSuccessState) {
        widget.crBloc.add(
          CRFilterEvent(
            ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
            filtro: '',
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    //SUBS
    sub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyInputWidget(
            focusNode: fPesquisa,
            hintText: 'Digite o nome do cliente',
            label: 'Pesquisa',
            controller: pesquisaController,
            inputFormaters: [
              UpperCaseTextFormatter(),
            ],
            onChanged: (String? value) {
              widget.crBloc.add(
                CRFilterEvent(
                  ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
                  filtro: value!,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          BlocListener<CCustoBloc, CCustoStates>(
            bloc: Modular.get<CCustoBloc>(),
            listenWhen: (previous, current) {
              return current is CCustoSuccessState;
            },
            listener: (context, state) {
              FocusScope.of(context).requestFocus(FocusNode());
              pesquisaController.clear();
              widget.crBloc.add(
                CRFilterEvent(ccusto: state.selectedEmpresa, filtro: ''),
              );
            },
            child: BlocBuilder<CRBloc, CRStates>(
              bloc: widget.crBloc,
              buildWhen: (previous, current) {
                return current is CRFilteredState;
              },
              builder: (context, state) {
                if (state is! CRFilteredState && state is! CRSuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, snapshot) {
                        return const LoadingWidget(
                          size: Size(0, 55),
                          radius: 10,
                        );
                      },
                    ),
                  );
                }

                final crs = state.filtredList;

                if (crs.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('Nenhum cliente encontrado.'),
                    ),
                  );
                }

                final totalGeral = state.saldoCR;

                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Geral',
                              style: context.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              totalGeral.reais(),
                              style: ThemeModeController.themeMode ==
                                      ThemeMode.dark
                                  ? context.textTheme.headlineLarge!.copyWith(
                                      color: const Color(0xffCB5252),
                                      fontWeight: FontWeight.bold,
                                    )
                                  : context.textTheme.headlineLarge!.copyWith(
                                      color: context.myTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return MyListTileCRWidget(cr: crs[index]);
                            },
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                            itemCount: crs.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
