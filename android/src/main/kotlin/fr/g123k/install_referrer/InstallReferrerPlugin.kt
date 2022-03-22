package fr.g123k.install_referrer

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** InstallReferrerPlugin */
class InstallReferrerPlugin : FlutterPlugin, InstallReferrerPigeon.InstallReferrerInternalAPI {

    var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        InstallReferrerPigeon.InstallReferrerInternalAPI.setup(
            flutterPluginBinding.binaryMessenger,
            this
        )

        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        InstallReferrerPigeon.InstallReferrerInternalAPI.setup(
            binding.binaryMessenger,
            null
        )

        context = null
    }

    override fun detectReferrer(result: InstallReferrerPigeon.Result<InstallReferrerPigeon.IRInstallationReferer>?) {
        context!!.run {
            val installerPackageName = packageManager.getInstallerPackageName(packageName)

            if (installerPackageName == null) {
                result?.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.debug,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.manually,
                    )
                )
            } else if (installerPackageName.startsWith("com.amazon")) {
                result?.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.appStore,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.amazonAppStore,
                    )
                )
            } else if (installerPackageName == "com.android.vending") {
                result?.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.appStore,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.googlePlay,
                    )
                )
            } else if (installerPackageName == "com.sec.android.app.samsungapps") {
                result?.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.appStore,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.samsungAppShop,
                    )
                )
            } else if (installerPackageName == "com.google.android.packageinstaller") {
                result?.success(
                    generateResult(
                        type = InstallReferrerPigeon.IRInstallationType.unknown,
                        platform = InstallReferrerPigeon.IRInstallationPlatform.manually,
                    )
                )
            } else {
                result?.error(Exception("Unknown installer $installerPackageName"))
            }
        }

    }

    private fun generateResult(
        type: InstallReferrerPigeon.IRInstallationType,
        platform: InstallReferrerPigeon.IRInstallationPlatform
    ): InstallReferrerPigeon.IRInstallationReferer {
        return InstallReferrerPigeon.IRInstallationReferer().apply {
            this.type = type
            this.platform = platform
        }
    }
}
