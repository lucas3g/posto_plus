// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/local_storage_interface.dart';
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
  final nome = GlobalUser.instance.user.nome;

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
                      nome.value,
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
                Column(
                  children: [
                    ListTile(
                      onTap: () async {
                        final localStorage = Modular.get<ILocalStorage>();

                        await localStorage.removeData('user');
                        await localStorage.removeData('DEVICE_ID');

                        await Future.delayed(const Duration(milliseconds: 150));

                        Modular.to.navigate('/auth/');
                      },
                      minLeadingWidth: 2,
                      leading: Icon(
                        Icons.exit_to_app,
                        color: appStore.themeMode.value == ThemeMode.dark
                            ? context.myTheme.primaryContainer
                            : context.myTheme.error,
                      ),
                      title: const Text(
                        'Sair',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        'Versão 1.0.0',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
