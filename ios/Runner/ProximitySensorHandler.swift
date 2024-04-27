//
//  ProximitySensorHandler.swift
//  Runner
//
//  Created by Isha Bodiwala on 26/04/24.
//

import Foundation

class ProximitySensorHandler: NSObject, FlutterStreamHandler {
    var proximityObserver: DeviceProximityMonitor?

    override init() {
        self.proximityObserver = DeviceProximityMonitor()
    }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.proximityObserver?.startProximityObserving { (proximity) in
            events(proximity)
        }
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.proximityObserver?.stopProximityObserving()
        return nil
    }
}

class DeviceProximityMonitor {
    var proximityObserver: NSObjectProtocol?
    var eventHandler: ((Double) -> Void)?

    func startProximityObserving(eventHandler: @escaping (Double) -> Void) {
        UIDevice.current.isProximityMonitoringEnabled = true
        self.eventHandler = eventHandler
        self.proximityObserver = NotificationCenter.default.addObserver(forName: UIDevice.proximityStateDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            self.eventHandler?(UIDevice.current.proximityState ? 0.0 : 1.0)
        }
    }

    func stopProximityObserving() {
        UIDevice.current.isProximityMonitoringEnabled = false
        if let observer = self.proximityObserver {
            NotificationCenter.default.removeObserver(observer)
            self.proximityObserver = nil
        }
    }
}

