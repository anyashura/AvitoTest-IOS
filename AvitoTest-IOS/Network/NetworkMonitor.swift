//
//  NetworkMonitor.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 20.11.2022.
//

import Foundation
import Network

final class NetworkMonitor {
    static var shared = NetworkMonitor()

    private var queue = DispatchQueue.global()
    private var monitor = NWPathMonitor()

    public var isConnected: Bool = false

    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
                print("Ok")
            } else {
                self.isConnected = false
                print("No connection.")
            }
        }
    }

    public func stopMonitoring() {
        monitor.cancel()
    }

}
