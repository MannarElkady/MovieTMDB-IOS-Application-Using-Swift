//
//  NetworkService.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation

class NetworkService{
    private let httpHandler: HttpHandler
    
    init(httpHandler:HttpHandler) {
        self.httpHandler = httpHandler
    }
    
    func getLatestMovies<T:Codable>(withPage page: Int, completionHandler : @escaping(T) -> Void , errorHandler : @escaping((Error)) -> Void) {
        
        let networkCompletionHandler = { (data:Data) -> Void
            in
            let movieArray = JsonMapper<T>().parseObject(jsonData: data)!
            completionHandler(movieArray)
        }
        
        let parameters = [
            "api_key":Constants.API_KEY,
            "language":"en-US",
            "page": String(page)
        ]
        
        print(parameters)
        var url = Constants.LATEST_URL
        self.httpHandler.getRequest(url: &url, completionHandler: networkCompletionHandler, errorHandler: errorHandler, parameters: parameters)
        
    }
}
