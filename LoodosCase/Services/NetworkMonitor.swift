//
//  NetworkMonitor.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 14.02.2021.
//

import Foundation
import Alamofire

class NetworkMonitor {
    static let shared = NetworkMonitor()

    func isConnectedToInternet() -> Bool {
            return NetworkReachabilityManager()?.isReachable ?? false
        }

}
