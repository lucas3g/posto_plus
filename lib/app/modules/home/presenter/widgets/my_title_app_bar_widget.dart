import 'package:flutter/material.dart';
import 'package:posto_plus/app/utils/constants.dart';

class MyTitleAppBarWidget extends StatefulWidget {
  final int index;
  const MyTitleAppBarWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<MyTitleAppBarWidget> createState() => _MyTitleAppBarWidgetState();
}

class _MyTitleAppBarWidgetState extends State<MyTitleAppBarWidget> {
  Widget retornaTitle() {
    if (widget.index == 0) {
      return Text(
        'Resumo de Vendas',
        style: context.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      );
    }
    if (widget.index == 1) {
      return Text(
        'Tanques',
        style: context.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      );
    }
    if (widget.index == 2) {
      return Text(
        'Contas a Receber',
        style: context.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      );
    }

    return Text(
      'Preço por Cliente',
      style: context.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return retornaTitle();
  }
}
