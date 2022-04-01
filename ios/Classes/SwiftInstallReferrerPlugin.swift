import Flutter
import UIKit

private var isDebug: Bool {
  #if DEBUG
    return true
  #else
    return false
  #endif
}

private let isFromTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"


public class SwiftInstallReferrerPlugin: NSObject, FlutterPlugin, IRInstallReferrerInternalAPI {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : IRInstallReferrerInternalAPI & NSObjectProtocol = SwiftInstallReferrerPlugin.init()
        IRInstallReferrerInternalAPISetup(messenger, api);
    }
    
    public func detectReferrer(completion: @escaping (IRIRInstallationReferer?, FlutterError?) -> Void) {
        let result = IRIRInstallationReferer.init()
        result.platform = IRIRPlatform.ios
        result.packageName = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        
        if (isDebug) {
            result.type = IRIRInstallationType.debug
            result.installationPlatform = IRIRInstallationPlatform.manually
        } else if (isFromTestFlight) {
            result.type = IRIRInstallationType.test
            result.installationPlatform = IRIRInstallationPlatform.appleTestflight
        } else {
            result.type = IRIRInstallationType.appStore
            result.installationPlatform = IRIRInstallationPlatform.appleAppStore
        }
        
        completion(result, nil)
    }
}
