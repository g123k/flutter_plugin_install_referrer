#import "InstallReferrerPlugin.h"
#if __has_include(<install_referrer/install_referrer-Swift.h>)
#import <install_referrer/install_referrer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "install_referrer-Swift.h"
#endif

@implementation InstallReferrerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInstallReferrerPlugin registerWithRegistrar:registrar];
}
@end
