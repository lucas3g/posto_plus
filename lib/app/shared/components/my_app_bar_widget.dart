import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/shared/stores/app_store.dart';

class MyAppBarWidget extends StatefulWidget {
  final String titleAppbar;
  const MyAppBarWidget({
    Key? key,
    required this.titleAppbar,
  }) : super(key: key);

  @override
  State<MyAppBarWidget> createState() => _MyAppBarWidgetState();
}

class _MyAppBarWidgetState extends State<MyAppBarWidget> {
  final height = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>(
      (store) => store.themeMode,
    );

    final tela = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(tela.width, height + (tela.height == 672 ? 50 : 75)),
      child: Stack(
        children: [
          Container(
            height: height + (tela.height == 672 ? 40 : 60),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding:
                EdgeInsets.only(left: 20, top: (tela.height == 672 ? 0 : 10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Vendas',
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () async {},
                )
              ],
            ),
          ),
          Container(),
          Positioned(
            top: (tela.height == 672 ? 65 : 85.0),
            left: 20.0,
            right: 20.0,
            child: Container(
              color: Colors.white,
              width: 100,
              height: 50,
            ),
          )
        ],
      ),
    );
  }
}
