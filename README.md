# install_referrer

[![Pub](https://img.shields.io/pub/v/flutter_install_referrer.svg)](https://pub.dartlang.org/packages/install_referrer)

A Flutter plugin that allows you to detect how your application was installed.

## Supported platforms

- Android: ✅
- iOS: ✅ 

Feel free to open a PR to support new platforms.

## Installation

1. Add `install_referrer: ^1.0.2` to your `pubspec.yaml` file.
2. Import `import 'package:install_referrer/install_referrer.dart';`
3. Get the value by invoking the `Future` `InstallReferrer.referrer`


## Possibles values

### Android

| Store               | Value                                             |
|---------------------|---------------------------------------------------|
| Google Play         | `InstallationAppReferrer.androidGooglePlay`       |
| Amazon App Store    | `InstallationAppReferrer.androidAmazonAppStore`   |
| Huawei App Gallery  | `InstallationAppReferrer.androidHuaweiAppGallery` |
| Samsung App Shop    | `InstallationAppReferrer.androidSamsungAppShop`   |
| Others              | `InstallationAppReferrer.androidManually`         |

If the application was installed from a third party app (eg: GMail, Google Drive, Chrome…), it will be considered as a **manual installation** (`InstallationAppReferrer.androidManually`).

If the application was installed from a store (FDroid, Amazon App Shop…) which was not preinstalled on the device (a _"non-system"_ app), it will also be considered as a **manual installation** (`InstallationAppReferrer.androidManually`).

If the Android application is in debug mode, it will be marked as `InstallationAppReferrer.androidDebug`.

### iOS

| Store            | Value                                            |
|------------------|--------------------------------------------------|
| App Store        | `InstallationAppReferrer.iosAppStore`            |
| Test Flight      | `InstallationAppReferrer.iosTestFlight`          |

If the iOS application is in debug mode (eg: from the simulator), it will be marked as `InstallationAppReferrer.iosDebug`.