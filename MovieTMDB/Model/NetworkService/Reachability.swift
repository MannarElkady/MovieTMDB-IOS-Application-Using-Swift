//
//  Reachability.swift
//  MovieTMDB
//
//  Created by Manar on 6/6/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation
import Alamofire

extension NetworkService {
    class var isNetworkAvailable : Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class NetworkReachability {

    private init(){
        
    }
    //shared instance
    static let shared = NetworkReachability()
    func startNetworkReachabilityObserver() {
        let net = NetworkReachabilityManager()
        let bool = net?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: {
            status in
            switch status {

            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")

            case .reachable(.cellular):
                print("The network is reachable over the WWAN connection")

            case .notReachable:
                print("The network is not reachable")

            case .unknown :
                print("It is unknown whether the network is reachable")
                
            }
        })
    }
    
}

