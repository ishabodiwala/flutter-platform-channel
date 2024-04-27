import UIKit
import Flutter
import CoreMotion

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterEventChannel(name: "proximity_sensor", binaryMessenger: flutterViewController.binaryMessenger)
    channel.setStreamHandler(ProximitySensorHandler())
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

