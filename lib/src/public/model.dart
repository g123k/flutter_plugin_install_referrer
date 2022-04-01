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
  // Android - Samsung AppShop
  androidSamsungAppShop,
  // Android - Manually (from a third party like Chrome, GMail…)
  androidManually,
  // Android - Debug mode
  androidDebug,
}
