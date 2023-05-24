import 'package:flutter/material.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/modules/home/presenter/widgets/my_drawer_widget.dart';
import 'package:posto_plus/app/shared/components/my_elevated_button_widget.dart';
import 'package:posto_plus/app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _appBar(height) {
    return PreferredSize(
      preferredSize: Size(context.screenWidth,
          height + (context.screenHeight == 672 ? 50 : 75)),
      child: Stack(
        children: [
          Container(
            height: height + (context.screenHeight == 672 ? 40 : 60),
            width: context.screenWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: ThemeModeController.themeMode == ThemeMode.dark
                  ? context.myTheme.primaryContainer
                  : context.myTheme.primary.withRed(190),
            ),
            padding: EdgeInsets.only(
                left: 20, top: (context.screenHeight == 672 ? 0 : 10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vendas',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                }),
              ],
            ),
          ),
          Container(),
          Positioned(
            top: (context.screenHeight == 672 ? 65 : 85.0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      drawer: const MyDrawerWidget(),
      body: SafeArea(
        child: MyElevatedButtonWidget(
          width: 200,
          label: const Text('Muda tema'),
          icon: Icons.change_circle,
          onPressed: () {
            ThemeModeController.appStore.changeThemeMode(
              ThemeModeController.themeMode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
          },
        ),
      ),
    );
  }
}
