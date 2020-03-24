import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSocialMedia {
  void openSocialMedia({
    @required urlSocialMedia,
    @required bool isEmail,
    @required String emailTo,
  }) async {
    final String email = 'mailto:$emailTo';

    try {
      if (await canLaunch(!isEmail ? urlSocialMedia : email)) {
        await launch(!isEmail ? urlSocialMedia : email);
      } else {
        throw 'Tidak Dapat Mengakses $urlSocialMedia';
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

final openSocialMedia = OpenSocialMedia();
