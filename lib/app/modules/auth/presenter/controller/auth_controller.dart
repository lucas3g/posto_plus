import 'dart:io';

import 'package:posto_plus/app/utils/my_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController {
  static Future<void> openWhatsapp({
    required String text,
    required String number,
  }) async {
    var whatsappURlAndroid = "whatsapp://send?phone=$number&text=$text";
    var whatsappURLIos =
        "https://wa.me/${number.replaceAll('+', '')}?text=$text";

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos));
      } else {
        MySnackBar(
          title: 'Atenção',
          message: 'Whatsapp não está instalado.',
          type: TypeSnack.warning,
        );
      }
    } else {
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        MySnackBar(
          title: 'Atenção',
          message: 'Whatsapp não está instalado.',
          type: TypeSnack.warning,
        );
      }
    }
  }
}
