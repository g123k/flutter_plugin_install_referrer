import 'package:flutter/material.dart';
import 'package:install_referrer/install_referrer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Installation Referrer plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: InstallReferrer.app,
                builder: (BuildContext context,
                    AsyncSnapshot<InstallationApp> result) {
                  if (!result.hasData) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (result.hasError) {
                    return const Text('Unable to detect your referrer');
                  } else {
                    return Text(
                      'Package name:\n${result.data!.packageName ?? 'Unknown'}\n'
                      'Referrer:\n${referrerToReadableString(result.data!.referrer)}',
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
              InstallReferrerDetectorBuilder(
                builder: (BuildContext context, InstallationApp? app) {
                  if (app == null) {
                    return const CircularProgressIndicator.adaptive();
                  } else {
                    return Text(
                      'Package name:\n${app.packageName ?? 'Unknown'}\n'
                      'Referrer:\n${referrerToReadableString(app.referrer)}',
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
              InstallReferrerDetectorListener(
                child: const Text('Listener'),
                onReferrerAvailable: (InstallationApp? app) {
                  // ignore: avoid_print
                  print(app?.referrer);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String referrerToReadableString(InstallationAppReferrer referrer) {
    switch (referrer) {
      case InstallationAppReferrer.iosAppStore:
        return "Apple - App Store";
      case InstallationAppReferrer.iosTestFlight:
        return "Apple - Test Flight";
      case InstallationAppReferrer.iosDebug:
        return "Apple - Debug";
      case InstallationAppReferrer.androidGooglePlay:
        return "Android - Google Play";
      case InstallationAppReferrer.androidAmazonAppStore:
        return "Android - Amazon App Store";
      case InstallationAppReferrer.androidHuaweiAppGallery:
        return "Android - Huawei App Gallery";
      case InstallationAppReferrer.androidOppoAppMarket:
        return "Android - Oppo App Market";
      case InstallationAppReferrer.androidSamsungAppShop:
        return "Android - Samsung App Shop";
      case InstallationAppReferrer.androidVivoAppStore:
        return "Android - Vivo App Store";
      case InstallationAppReferrer.androidXiaomiAppStore:
        return "Android - Xiaomi App Store";
      case InstallationAppReferrer.androidManually:
        return "Android - Manual installation";
      case InstallationAppReferrer.androidDebug:
        return "Android - Debug";
    }
  }
}
