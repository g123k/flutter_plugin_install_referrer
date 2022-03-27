import 'package:install_referrer/install_referrer.dart';

import '../private/pigeon_api.dart';

class InstallReferrer {
  static late final InstallReferrerInternalAPI _api =
      InstallReferrerInternalAPI();

  static Future<InstallationAppReferrer> get referrer async {
    IRInstallationReferer referrer = await _api.detectReferrer();

    switch (referrer.platform) {
      case IRPlatform.ios:
        return _iOSReferrer(
          referrer.installationPlatform,
        );
      case IRPlatform.android:
        return _androidReferrer(
          referrer.installationPlatform,
          referrer.type,
        );
      default:
        throw UnsupportedError(
          'Unsupported platform ${referrer.platform}',
        );
    }
  }

  static InstallationAppReferrer _iOSReferrer(
    IRInstallationPlatform? platform,
  ) {
    if (platform == IRInstallationPlatform.appleAppStore) {
      return InstallationAppReferrer.iosAppStore;
    } else if (platform == IRInstallationPlatform.appleTestflight) {
      return InstallationAppReferrer.iosTestFlight;
    } else {
      return InstallationAppReferrer.iosDebug;
    }
  }

  static InstallationAppReferrer _androidReferrer(
    IRInstallationPlatform? platform,
    IRInstallationType? type,
  ) {
    assert(type != null);

    switch (platform) {
      case IRInstallationPlatform.googlePlay:
        return InstallationAppReferrer.androidGooglePlay;
      case IRInstallationPlatform.amazonAppStore:
        return InstallationAppReferrer.androidAmazonAppStore;
      case IRInstallationPlatform.samsungAppShop:
        return InstallationAppReferrer.androidSamsungAppShop;
      case IRInstallationPlatform.manually:
        if (type == IRInstallationType.debug) {
          return InstallationAppReferrer.androidDebug;
        } else {
          return InstallationAppReferrer.androidManually;
        }
      case IRInstallationPlatform.unknown:
        return InstallationAppReferrer.androidDebug;
      default:
        throw UnimplementedError('Unsupported platform $platform!');
    }
  }
}
