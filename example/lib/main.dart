import 'package:flutter/material.dart';
import 'package:install_referrer/install_referrer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Installation Referrer plugin example app'),
        ),
        body: Center(
          child: FutureBuilder(
            future: InstallReferrer.referrer,
            builder: (BuildContext context,
                AsyncSnapshot<InstallationAppReferrer> result) {
              if (!result.hasData) {
                return const CircularProgressIndicator.adaptive();
              } else if (result.hasError) {
                return const Text('Unable to detect your referrer');
              } else {
                return Text(
                  'Referrer:\n${toReadableString(result.data!)}',
                  textAlign: TextAlign.center,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  String toReadableString(InstallationAppReferrer referrer) {
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
      case InstallationAppReferrer.androidSamsungAppShop:
        return "Android - Samsung App Shop";
      case InstallationAppReferrer.androidManually:
        return "Android - Manual installation";
      case InstallationAppReferrer.androidDebug:
        return "Android - Debug";
    }
  }
}
