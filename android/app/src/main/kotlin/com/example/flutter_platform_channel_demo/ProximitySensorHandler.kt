package com.example.flutter_platform_channel_demo

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink


class ProximitySensorHandler(context: Context) : SensorEventListener, EventChannel.StreamHandler {
    private var sensorManager: SensorManager? = null
    private var proximitySensor: Sensor? = null
    private var proximity =  0.0f
    private var eventSink: EventSink? = null

    init {
        init(context)
    }


    private fun init(context: Context){
        sensorManager =
            context.getSystemService(
                Context.SENSOR_SERVICE
            ) as SensorManager
        proximitySensor =
            sensorManager!!.getDefaultSensor(
                Sensor.TYPE_PROXIMITY
            )
        sensorManager!!.registerListener(
            this,
            proximitySensor,
            SensorManager.SENSOR_DELAY_NORMAL
        )
    }

    override fun onListen(arguments: Any?, events: EventSink) {
        eventSink = events
    }

    override fun onCancel(arguments: Any) {
        sensorManager!!.unregisterListener(this)
        eventSink = null
    }

    override fun onSensorChanged(event: SensorEvent) {
        if (event.sensor.type == Sensor.TYPE_PROXIMITY) {
            if (eventSink != null) {
                proximity = event.values[0]
                eventSink!!.success(proximity)
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {
        // Not used, but required to implement SensorEventListener
    }
}

