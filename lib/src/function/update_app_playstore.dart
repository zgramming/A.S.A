import 'package:firebase_remote_config/firebase_remote_config.dart';

class UpdateAppPlaystore {
  final String firebaseRemoteKey = "android_build_version";

  Future<bool> isNeedUpdate(String currentBuildVersion) async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    //! Harus di setting agar value dari firebase remote config tidak di cache, setting menjadi 0 second.
    await remoteConfig.fetch(expiration: Duration(seconds: 0));
    await remoteConfig.activateFetched();
    final newestBuildVersion = remoteConfig.getString(firebaseRemoteKey);
    print(
        "Current Version $currentBuildVersion || NewestVersion $newestBuildVersion");
    if (newestBuildVersion != currentBuildVersion) {
      print('Butuh Update');
      return true;
    } else {
      print('Sudah Paling Baru');
      return false;
    }
  }
}

final updateAppPlaystore = UpdateAppPlaystore();
