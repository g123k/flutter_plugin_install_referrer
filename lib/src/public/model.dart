/// A wrapper containing the [InstallationAppReferrer] result, with the
/// package name (Android) or App ID (iOS)
class InstallationApp {
  /// Package name (Android) or App ID (iOS)
  final String? packageName;
  final InstallationAppReferrer referrer;

  InstallationApp({
    required this.packageName,
    required this.referrer,
  });

  @override
  String toString() {
    return 'InstallationApp{packageName: $packageName, referrer: $referrer}';
  }
}

/// Result from a call to [InstallReferrer.referrer]
enum InstallationAppReferrer {
  // iOS - Apple App Store
  iosAppStore,
  // iOS - Test Flight
  iosTestFlight,
  // iOS - Debug mode (simulator)
  iosDebug,
  // Android - Google Play
  androidGooglePlay,
  // Android - Amazon AppStore
  androidAmazonAppStore,
  // Android / Harmony OS - Huawei App Gallery
  androidHuaweiAppGallery,
  // Android - Oppo App Market
  androidOppoAppMarket,
  // Android - Samsung AppShop
  androidSamsungAppShop,
  // Android - Vivo App Store
  androidVivoAppStore,
  // Android - Xiaomi App Store
  androidXiaomiAppStore,
  // Android - Manually (from a third party like Chrome, GMail…)
  androidManually,
  // Android - Debug mode
  androidDebug,
}
