package com.relario.relario_flutter_demo

import android.Manifest
import android.Manifest.permission_group.SMS
import android.app.PendingIntent
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.telephony.SmsManager
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec


class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.relario.demo/background_send"
    private val BG_CHANNEL = "com.relario.demo/bg_send"
    private val TAG = "FLUTTER_DEMO"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            Log.v(TAG, "Received CALL ${call.method}");
            if (call.method.equals("SendSms")) {
                if (isSMSPermissionGranted()) {
                    sendSms(
                        call.argument<List<String>>("phoneList"),
                        call.argument<String>("smsBody")
                    )
                    result.success(true);
                } else {
                    result.success(false);
                }
            } else {
                result.notImplemented();
            }
            // This method is invoked on the main thread.
            // TODO
        }
    }

    fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val taskQueue =
            flutterPluginBinding.binaryMessenger.makeBackgroundTaskQueue()
        MethodChannel(
            flutterPluginBinding.binaryMessenger,
            BG_CHANNEL,
            StandardMethodCodec.INSTANCE,
            taskQueue
        ).setMethodCallHandler { call, result ->
            Log.v(TAG, "Received CALL ${call.method}");
            if (call.method.equals("SendSms")) {
                if (isSMSPermissionGranted()) {
                    sendSms(
                        call.argument<List<String>>("phoneList"),
                        call.argument<String>("smsBody")
                    )
                    result.success(true);
                } else {
                    result.success(false);
                }
            } else {
                result.notImplemented();
            }
        }
    }

    fun sendSms(phoneNumberList: List<String>?, smsBody: String?) {
        Toast.makeText(context, "Sending SMS", Toast.LENGTH_SHORT).show()
        var smsManager: SmsManager;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
            smsManager = SmsManager.getSmsManagerForSubscriptionId(100)
        } else {
            smsManager = SmsManager.getDefault();
        }
        phoneNumberList?.forEach {
            val pi = PendingIntent.getActivity(
                this, 1000,
                Intent(this, SMS::class.java), PendingIntent.FLAG_IMMUTABLE
            )
            smsManager.sendTextMessage(it, null, smsBody, pi, null)
        }

    }

    fun isSMSPermissionGranted(): Boolean {
        if (Build.VERSION.SDK_INT >= 23) {
            return if (checkSelfPermission(android.Manifest.permission.SEND_SMS)
                == PackageManager.PERMISSION_GRANTED
            ) {
                Log.v(TAG, "Permission is granted");
                true;
            } else {

                Log.v(TAG, "Permission is revoked");
                requestPermissions(
                    arrayOf(Manifest.permission.SEND_SMS),
                    1
                )
                false;
            }
        } else { //permission is automatically granted on sdk<23 upon installation
            Log.v(TAG, "Permission is granted");
            return true;
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        if (requestCode == 1) {
            if (grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(context, "Permission Granted", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(context, "Permission Denied", Toast.LENGTH_SHORT).show()

            }
            return;
        }
        return;
    }
}
