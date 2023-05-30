import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/modules/home/presenter/controller/home_controller.dart';
import 'package:posto_plus/app/modules/home/presenter/widgets/my_drawer_widget.dart';
import 'package:posto_plus/app/modules/home/presenter/widgets/my_title_app_bar_widget.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/presenter/drop_down_widget.dart';
import 'package:posto_plus/app/utils/constants.dart';

class HomePage extends StatefulWidget {
  final CCustoBloc ccustoBloc;

  const HomePage({
    Key? key,
    required this.ccustoBloc,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class BottomRoundedClipper extends CustomClipper<Path> {
  final double borderRadius;

  BottomRoundedClipper({this.borderRadius = 65});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(
        0,
        size.height -
            borderRadius); // Linha reta até a parte inferior esquerda (borda bottomLeft)
    path.quadraticBezierTo(
      0,
      size.height - 25,
      borderRadius,
      size.height - 25,
    ); // Curva de Bezier quadrática para criar a borda bottomLeft arredondada
    path.lineTo(
        size.width - borderRadius,
        size.height -
            25); // Linha reta até a parte inferior direita (antes da borda bottomRight)

    path.quadraticBezierTo(
      size.width,
      size.height - 25,
      size.width,
      size.height,
    ); // Curva de Bezier quadrática para criar a borda bottomRight arredondada para dentro

    path.lineTo(size.width, 0); // Linha reta até a parte superior direita

    path.lineTo(0, 0);

    path.quadraticBezierTo(
      0,
      0,
      0,
      borderRadius,
    ); // Curva de Bezier quadrática para criar a borda topLeft arredondada

    path.close(); // Fecha o caminho

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Modular.to.pushNamed('./vendas/');
  }

  _appBar(height) {
    return PreferredSize(
      preferredSize: Size(context.screenWidth, height + 90),
      child: ClipPath(
        clipper: BottomRoundedClipper(),
        child: Container(
          color: ThemeModeController.themeMode == ThemeMode.dark
              ? context.myTheme.primaryContainer
              : context.myTheme.primary,
          padding: const EdgeInsets.only(left: 20),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTitleAppBarWidget(index: _currentIndex),
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: DropDownWidget(
                    ccustoBloc: widget.ccustoBloc,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      drawer: const MyDrawerWidget(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: RouterOutlet(),
      ),
      bottomNavigationBar: GNav(
          backgroundColor: ThemeModeController.themeMode == ThemeMode.dark
              ? context.myTheme.primaryContainer
              : context.myTheme.primary,
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          curve: Curves.easeIn, // tab animation curves
          duration: const Duration(milliseconds: 500),
          gap: 8, // the tab button gap between icon and text
          activeColor: Colors.white, // selected icon and text color
          tabBackgroundColor: ThemeModeController.themeMode == ThemeMode.dark
              ? context.myTheme.primaryContainer.withOpacity(0.1)
              : context.myTheme.primary
                  .withOpacity(0.1), // selected tab background color
          padding: Platform.isAndroid
              ? const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
              : const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });

            HomeController.navigation(index);
          },
          tabs: const [
            GButton(
              icon: Icons.attach_money_rounded,
              text: 'Vendas',
              iconColor: Colors.white,
            ),
            GButton(
              icon: Icons.local_gas_station,
              text: 'Tanques',
              iconColor: Colors.white,
            ),
            GButton(
              icon: Icons.account_balance_rounded,
              text: 'Contas a Receber',
              iconColor: Colors.white,
            ),
            GButton(
              icon: Icons.payments_rounded,
              text: 'Preço por Cliente',
              iconColor: Colors.white,
            ),
          ]),
    );
  }
}
