import 'package:atur_semua_aktifitas/src/ui/variable/config/app_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Goto {
  void gotoPlaystore() async {
    final url = appConfig.urlApplication;
    try {
      if (await canLaunch(url)) {
        Future.delayed(Duration(milliseconds: 2500), () => launch(url));
      } else {
        throw 'Tidak Dapat Mengakses $url';
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

final goTo = Goto();
