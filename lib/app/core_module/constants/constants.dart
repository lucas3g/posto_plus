import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:posto_plus/app/modules/auth/domain/entities/user.dart';
import 'package:posto_plus/app/modules/auth/infra/adapters/user_adapter.dart';

const baseUrl = String.fromEnvironment('BASE_URL');
const baseUrlLicense = String.fromEnvironment('BASE_URL_LICENSE');

const pathLogo = 'assets/images/logo.svg';

const backgroundBlack = Color(0xFF202123);

const urlProjecao = 'vendas/projecao';
const urlGrafico = 'vendas/grafico';
const urlVendas = 'vendas/vendas';
const urlTanques = 'tanques/volume';

class GlobalUser {
  GlobalUser._();

  static GlobalUser instance = GlobalUser._();

  User get user {
    final shared = Modular.get<ILocalStorage>();

    return UserAdapter.fromMap(
      jsonDecode(
        shared.getData('user'),
      ),
    );
  }
}

class GlobalDevice {
  GlobalDevice._();

  static GlobalDevice instance = GlobalDevice._();

  DeviceInfo get deviceInfo {
    final shared = Modular.get<ILocalStorage>();

    return DeviceInfo(deviceID: shared.getData('DEVICE_ID'));
  }
}

final cnpjSemCaracter =
    UtilBrasilFields.removeCaracteres(GlobalUser.instance.user.cnpj.value)
        .substring(0, 8);
