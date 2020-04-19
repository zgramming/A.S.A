import 'package:firebase_remote_config/firebase_remote_config.dart';

class UpdateAppPlaystore {
  final String firebaseRemoteKey = "android_build_version";

  Future<bool> isNeedUpdate(String currentBuildVersion) async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    final newestBuildVersion = remoteConfig.getString(firebaseRemoteKey);
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
