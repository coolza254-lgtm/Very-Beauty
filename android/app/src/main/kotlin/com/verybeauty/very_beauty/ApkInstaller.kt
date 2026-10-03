package com.verybeauty.very_beauty

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInstaller
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import androidx.core.app.NotificationCompat
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * Installs a downloaded update APK through PackageInstaller.
 *
 * Android always asks the user the first time. Once Very Beauty has installed
 * itself (it becomes the "installer of record"), Android 12+ lets later
 * updates go through without the confirmation screen.
 */
object ApkInstaller {
    private const val ACTION_STATUS = "com.verybeauty.very_beauty.INSTALL_STATUS"

    /** Reports install results back to Dart while the app is running. */
    var channel: MethodChannel? = null

    fun handle(context: Context, method: String, path: String?, result: MethodChannel.Result) {
        when (method) {
            "canInstall" -> result.success(canInstall(context))
            "supportedAbis" -> result.success(Build.SUPPORTED_ABIS.toList())
            "openInstallSettings" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    val intent = Intent(
                        Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,
                        Uri.parse("package:" + context.packageName),
                    ).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    context.startActivity(intent)
                }
                result.success(null)
            }
            "install" -> {
                if (path == null) {
                    result.error("bad_args", "path is required", null)
                    return
                }
                // Copying a large APK into the session takes a moment; keep it
                // off the UI thread and answer on the main thread.
                val main = Handler(Looper.getMainLooper())
                Thread {
                    try {
                        install(context, File(path))
                        main.post { result.success(null) }
                    } catch (e: Exception) {
                        main.post { result.error("install_failed", e.message, null) }
                    }
                }.start()
            }
            else -> result.notImplemented()
        }
    }

    private fun canInstall(context: Context): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.O ||
            context.packageManager.canRequestPackageInstalls()

    private fun install(context: Context, apk: File) {
        val installer = context.packageManager.packageInstaller
        val params = PackageInstaller.SessionParams(PackageInstaller.SessionParams.MODE_FULL_INSTALL)
        params.setAppPackageName(context.packageName)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            params.setRequireUserAction(PackageInstaller.SessionParams.USER_ACTION_NOT_REQUIRED)
        }
        val sessionId = installer.createSession(params)
        installer.openSession(sessionId).use { session ->
            apk.inputStream().use { input ->
                session.openWrite("base.apk", 0, apk.length()).use { output ->
                    input.copyTo(output)
                    session.fsync(output)
                }
            }
            val intent = Intent(context, InstallResultReceiver::class.java).setAction(ACTION_STATUS)
            var flags = PendingIntent.FLAG_UPDATE_CURRENT
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                flags = flags or PendingIntent.FLAG_MUTABLE
            }
            val pending = PendingIntent.getBroadcast(context, sessionId, intent, flags)
            session.commit(pending.intentSender)
        }
    }

    /** Sends a status code (see PackageInstaller.STATUS_*) to Dart. */
    fun report(status: Int, message: String?) {
        Handler(Looper.getMainLooper()).post {
            channel?.invokeMethod("onInstallStatus", mapOf("status" to status, "message" to message))
        }
    }
}

/** Receives the PackageInstaller result; shows the system prompt if needed. */
class InstallResultReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val status = intent.getIntExtra(PackageInstaller.EXTRA_STATUS, PackageInstaller.STATUS_FAILURE)
        if (status == PackageInstaller.STATUS_PENDING_USER_ACTION) {
            @Suppress("DEPRECATION")
            val confirm = intent.getParcelableExtra<Intent>(Intent.EXTRA_INTENT)
            if (confirm != null) {
                confirm.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                context.startActivity(confirm)
            }
        }
        ApkInstaller.report(status, intent.getStringExtra(PackageInstaller.EXTRA_STATUS_MESSAGE))
    }
}

/** After an update replaces the app, offer a one-tap way back in. */
class UpdatedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Intent.ACTION_MY_PACKAGE_REPLACED) return
        val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            manager.createNotificationChannel(
                NotificationChannel("app_update", "App updates", NotificationManager.IMPORTANCE_DEFAULT),
            )
        }
        val launch = context.packageManager.getLaunchIntentForPackage(context.packageName) ?: return
        val open = PendingIntent.getActivity(
            context, 0, launch, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val notification = NotificationCompat.Builder(context, "app_update")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Very Beauty")
            .setContentText(context.getString(R.string.update_installed))
            .setContentIntent(open)
            .setAutoCancel(true)
            .build()
        try {
            manager.notify(9001, notification)
        } catch (e: SecurityException) {
            // Notifications not allowed; the user simply reopens the app.
        }
    }
}
