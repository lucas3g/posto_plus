import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/events/ccusto_event.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/loading_widget.dart';

class DropDownWidget extends StatefulWidget {
  final CCustoBloc ccustoBloc;
  const DropDownWidget({
    Key? key,
    required this.ccustoBloc,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  void initState() {
    super.initState();

    widget.ccustoBloc.add(GetCCustoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 10,
            color: ThemeModeController.themeMode == ThemeMode.dark
                ? context.myTheme.primaryContainer.withOpacity(0.23)
                : context.myTheme.primary.withOpacity(0.23),
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<CCustoBloc, CCustoStates>(
              bloc: widget.ccustoBloc,
              buildWhen: (previous, current) {
                return current is CCustoSuccessState;
              },
              builder: (context, state) {
                if (state is! CCustoSuccessState) {
                  return Row(
                    children: const [
                      Expanded(
                        child: LoadingWidget(size: Size(0, 40), radius: 10),
                      ),
                    ],
                  );
                }

                final ccustos = state.ccustos;
                final initialValue = state.selectedEmpresa;

                return DropdownButton(
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  value: initialValue,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_circle_down_sharp,
                  ),
                  iconEnabledColor:
                      ThemeModeController.themeMode == ThemeMode.dark
                          ? context.myTheme.primaryContainer
                          : context.myTheme.primary,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                  ),
                  iconSize: 30,
                  elevation: 8,
                  underline: Container(),
                  onChanged: (int? newValue) {
                    widget.ccustoBloc.add(ChangeCCustoEvent(ccusto: newValue!));
                  },
                  items: ccustos.map((local) {
                    return DropdownMenuItem(
                      value: local.ccusto.value,
                      child: Text(local.descricao.value),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
