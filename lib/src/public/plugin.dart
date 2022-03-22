import 'dart:io';

import 'package:install_referrer/install_referrer.dart';

import '../api.dart';

class InstallReferrer {
  static late final InstallReferrerInternalAPI _api =
      InstallReferrerInternalAPI();

  static Future<InstallationAppReferrer> get referrer async {
    IRInstallationReferer referrer = await _api.detectReferrer();

    switch (referrer.platform) {
      case IRInstallationPlatform.appleAppStore:
        return InstallationAppReferrer.appleAppStore;
      case IRInstallationPlatform.appleTestflight:
        return InstallationAppReferrer.appleTestFlight;
      case IRInstallationPlatform.googlePlay:
        return InstallationAppReferrer.androidGooglePlay;
      case IRInstallationPlatform.amazonAppStore:
        return InstallationAppReferrer.androidAmazonAppStore;
      case IRInstallationPlatform.samsungAppShop:
        return InstallationAppReferrer.androidSamsungAppShop;
      case IRInstallationPlatform.manually:
        return InstallationAppReferrer.androidManually;
      case IRInstallationPlatform.unknown:
        if (Platform.isIOS) {
          return InstallationAppReferrer.iosDebug;
        } else {
          return InstallationAppReferrer.androidDebug;
        }
      default:
        throw Exception('Unknown platform!');
    }
  }
}
