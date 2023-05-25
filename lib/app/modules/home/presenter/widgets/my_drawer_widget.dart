// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/shared/stores/app_store.dart';
import 'package:posto_plus/app/utils/constants.dart';

class MyDrawerWidget extends StatefulWidget {
  const MyDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>(
      (store) => store.themeMode,
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: context.screenHeight * .15,
            child: Theme(
              data: ThemeData().copyWith(
                dividerColor: context.myTheme.background,
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: appStore.themeMode.value == ThemeMode.dark
                      ? context.myTheme.onPrimary
                      : context.myTheme.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lucas Emanuel Silva',
                      style: context.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: context.screenHeight * .85,
            color: appStore.themeMode.value == ThemeMode.dark
                ? backgroundBlack
                : context.myTheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                      minLeadingWidth: 2,
                      leading: Icon(
                        appStore.themeMode.value == ThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: appStore.themeMode.value == ThemeMode.dark
                            ? context.myTheme.primaryContainer
                            : context.myTheme.error,
                      ),
                      title: Text(
                        appStore.themeMode.value == ThemeMode.dark
                            ? 'Dark'
                            : 'Light',
                      ),
                      onTap: () {
                        appStore.changeThemeMode(
                          appStore.themeMode.value == ThemeMode.dark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        );
                      },
                    ),
                  ],
                ),
                const ListTile(
                  title: Text(
                    'Versão 1.0.0',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
