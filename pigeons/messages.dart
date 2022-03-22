import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    javaOptions: JavaOptions(
      className: 'InstallReferrerPigeon',
      package: 'fr.g123k.install_referrer',
    ),
    objcOptions: ObjcOptions(
      prefix: 'IR',
    ),
    dartOptions: DartOptions(
      isNullSafe: true,
    ),
    dartOut: './lib/src/api.dart',
    objcHeaderOut: './ios/Classes/messages.h',
    objcSourceOut: './ios/Classes/messages.m',
    javaOut:
        './android/src/main/java/fr/g123k/install_referrer/InstallReferrerPigeon.java',
  ),
)
class IRInstallationReferer {
  final IRInstallationType? type;
  final IRInstallationPlatform? platform;

  IRInstallationReferer({this.type, this.platform});
}

enum IRInstallationType {
  appStore,
  test,
  debug,
  unknown,
}

enum IRInstallationPlatform {
  appleAppStore,
  appleTestflight,
  googlePlay,
  amazonAppStore,
  samsungAppShop,
  manually,
  unknown,
}

@HostApi()
abstract class InstallReferrerInternalAPI {
  @async
  IRInstallationReferer detectReferrer();
}
