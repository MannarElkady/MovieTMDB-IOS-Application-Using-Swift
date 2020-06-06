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

