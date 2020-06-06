//
//  HttpHandler.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation
import Alamofire

protocol HttptHandlerProtocol{
    func getRequest(url : inout String ,completionHandler : @escaping(Data) -> Void , errorHandler : @escaping((Error)) -> Void,
                             parameters : [String:Any]?)
}


class HttpHandler:HttptHandlerProtocol{
    
    func getRequest(url : inout String ,completionHandler : @escaping(Data) -> Void , errorHandler : @escaping((Error)) -> Void,
                          parameters : [String:Any]?){
      
        prepareGetUrl(url : &url,parameters: parameters )
        AF.request(url).validate()
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    completionHandler(response.data!)
                default:
                    errorHandler(response.error!)
                }
        }
    }
    
    private func prepareGetUrl(url : inout String,parameters: [String:Any]?){
        if parameters != nil && parameters?.count ?? 0 > 0 {
            url.append("?")
            for(key,value) in parameters!{
                url.append("\(key)=\(value)&")
            }
        }
    }
}

