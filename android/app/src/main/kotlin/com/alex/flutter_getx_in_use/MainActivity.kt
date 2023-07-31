package com.alex.flutter_getx_in_use

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Bundle
import android.os.Handler
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    private val CHANNEL = "my_channel"
    private lateinit var channel: MethodChannel
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Create a FlutterEngine object
//        flutterEngine = FlutterEngine(this)
//
//        // Start executing Dart code in the FlutterEngine
//        flutterEngine.dartExecutor.executeDartEntrypoint(
//            DartExecutor.DartEntrypoint.createDefault()
//        )
//
//        // Load the Flutter module using the FlutterEngine
//        FlutterEngineCache
//            .getInstance()
//            .put("my_engine_id", flutterEngine)
//
//        // Call a method in the Flutter module using MethodChannel API
//        hi()
    }

    private fun hi() {
        channel.invokeMethod("my_method", "Android!")
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method == "getBatteryLevel") {
                    val batteryLevel = getBatteryLevel(this)
                    result.success(batteryLevel)
                } else {
                    result.notImplemented()
                }
            }
    }
    fun getBatteryLevel(context: Context): Int {
        val handler = Handler()
        handler.postDelayed({
            hi()
            Toast.makeText(this, "Hello, from Android Toast!", Toast.LENGTH_SHORT).show()
        }, 3000)
        val intent = context.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val level = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
        val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        return (level * 100 / scale.toFloat()).toInt()
    }
}
