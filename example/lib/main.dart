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
                return Text('Referrer: ${result.data}');
              }
            },
          ),
        ),
      ),
    );
  }
}
