package com.example.flutter_platform_channel_demo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
         val proximitySensorHandler = ProximitySensorHandler(this)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "proximity_sensor").setStreamHandler(proximitySensorHandler)
    }
}

