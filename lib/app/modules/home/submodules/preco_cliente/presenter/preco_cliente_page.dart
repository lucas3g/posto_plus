import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/modules/home/presenter/controller/home_controller.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/events/preco_cliente_events.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/preco_cliente_bloc.dart';
import 'package:posto_plus/app/modules/home/submodules/preco_cliente/presenter/bloc/states/preco_cliente_states.dart';
import 'package:posto_plus/app/shared/components/my_input_widget.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';
import 'package:posto_plus/app/utils/loading_widget.dart';

class PrecoClientePage extends StatefulWidget {
  final PrecoClienteBloc precoClienteBloc;

  const PrecoClientePage({
    Key? key,
    required this.precoClienteBloc,
  }) : super(key: key);

  @override
  State<PrecoClientePage> createState() => _PrecoClientePageState();
}

class _PrecoClientePageState extends State<PrecoClientePage> {
  Future<void> getAllData() async {
    await GetAllData.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyInputWidget(
            label: 'Pesquisa',
            hintText: 'Cliente, mercadoria, tipo ou preço',
            onChanged: (String? value) {
              widget.precoClienteBloc.add(
                PrecoClienteFilterEvent(filtro: value!),
              );
            },
            inputFormaters: [UpperCaseTextFormatter()],
          ),
          const SizedBox(height: 15),
          BlocBuilder<PrecoClienteBloc, PrecoClienteStates>(
            bloc: widget.precoClienteBloc,
            builder: (context, state) {
              if (state is! PrecoClienteFilteredState &&
                  state is! PrecoClienteSuccessState) {
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

              final precos = state.filtredList;

              if (precos.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text('Nenhum cliente encontrado.'),
                  ),
                );
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RefreshIndicator.adaptive(
                    onRefresh: getAllData,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: precos.length,
                      itemBuilder: (context, index) {
                        final cliente = precos[index];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 8,
                                  color: cliente.tipo.value == 'VALOR'
                                      ? ThemeModeController.themeMode ==
                                              ThemeMode.dark
                                          ? context.myTheme.primaryContainer
                                          : context.myTheme.primary
                                      : Colors.blue.shade700,
                                ),
                                right: BorderSide(
                                  width: 8,
                                  color: cliente.tipo.value == 'VALOR'
                                      ? ThemeModeController.themeMode ==
                                              ThemeMode.dark
                                          ? context.myTheme.primaryContainer
                                          : context.myTheme.primary
                                      : Colors.blue.shade700,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(cliente.cliente.value),
                                  subtitle: Text(cliente.mercadoria.value),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        cliente.tipo.value,
                                      ),
                                      SizedBox(
                                        height: 15,
                                        child: VerticalDivider(
                                          color: ThemeModeController
                                                      .themeMode ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : context.myTheme.onBackground,
                                          thickness: 1,
                                        ),
                                      ),
                                      Text(
                                        cliente.preco.value.reais(),
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          color: labelRed,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
