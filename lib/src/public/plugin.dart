import 'package:install_referrer/install_referrer.dart';

import '../private/pigeon_api.dart';

/// Detect which application (or store) installed an Android or iOS application
class InstallReferrer {
  static late final InstallReferrerInternalAPI _api =
      InstallReferrerInternalAPI();

  /// Provide app information with:
  /// - Package name / app id
  /// - Installation referred
  static Future<InstallationApp> get app async {
    IRInstallationReferer referrer = await _api.detectReferrer();

    return InstallationApp(
      packageName: referrer.packageName,
      referrer: _extractReferrer(
        referrer,
      ),
    );
  }

  /// Detect which application (or store) installed your application
  ///
  /// On Android, system apps are only recognized, otherwise they will be
  /// considered as manual installation
  static Future<InstallationAppReferrer> get referrer async {
    return _extractReferrer(await _api.detectReferrer());
  }

  static InstallationAppReferrer _extractReferrer(
    IRInstallationReferer referrer,
  ) {
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

  /// Detect on which platform the iOS app was installed
  /// Possible values are:
  /// - [InstallationAppReferrer.iosAppStore]
  /// - [InstallationAppReferrer.iosTestFlight]
  /// - [InstallationAppReferrer.iosDebug]
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

  /// Detect on which platform the Android app was installed
  /// Possible values are:
  /// - [InstallationAppReferrer.androidGooglePlay]
  /// - [InstallationAppReferrer.androidAmazonAppStore]
  /// - [InstallationAppReferrer.androidHuaweiAppGallery]
  /// - [InstallationAppReferrer.androidOppoAppMarket]
  /// - [InstallationAppReferrer.androidSamsungAppShop]
  /// - [InstallationAppReferrer.androidVivoAppStore]
  /// - [InstallationAppReferrer.androidXiaomiAppStore]
  /// - [InstallationAppReferrer.androidDebug]
  /// - [InstallationAppReferrer.androidManually]
  /// - [InstallationAppReferrer.androidDebug]
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
      case IRInstallationPlatform.huaweiAppGallery:
        return InstallationAppReferrer.androidHuaweiAppGallery;
      case IRInstallationPlatform.oppoAppMarket:
        return InstallationAppReferrer.androidOppoAppMarket;
      case IRInstallationPlatform.samsungAppShop:
        return InstallationAppReferrer.androidSamsungAppShop;
      case IRInstallationPlatform.vivoAppStore:
        return InstallationAppReferrer.androidVivoAppStore;
      case IRInstallationPlatform.xiaomiAppStore:
        return InstallationAppReferrer.androidXiaomiAppStore;
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
