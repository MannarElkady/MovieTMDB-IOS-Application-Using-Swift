//
//  NetworkMocking.swift
//  MovieTMDBTests
//
//  Created by Manar on 6/7/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation
@testable import MovieTMDB
class NetworkMocking {
    let mockingData: [String:Any] = [
        "results": [
            [
                "popularity": 21.595,
                "vote_count": 257,
                "video": false,
                "poster_path": "/rsUs58bDqpJJxZSOebZOMN9gzw2.jpg",
                "id": 506528,
                "adult": false,
                "backdrop_path": "/7o4MsDcZIqIApcApMUq1fPhkkA1.jpg",
                "original_language": "en",
                "original_title": "Harriet",
                "genre_ids": [
                    18,
                    36
                ],
                "title": "Harriet",
                "vote_average": 7.2,
                "overview": "The extraordinary tale of Harriet Tubman's escape from slavery and transformation into one of America's greatest heroes. Her courage, ingenuity and tenacity freed hundreds of slaves and changed the course of history.",
                "release_date": "2019-11-01"
            ],
        ],
        "page": 3,
        "total_results": 599,
        "dates": [
            "maximum": "2020-06-12",
            "minimum": "2020-04-25"
        ],
        "total_pages": 30
    ]
    
    var shouldReturnError = false
    init(shouldReturnError:Bool) {
        self.shouldReturnError = shouldReturnError
    }
    convenience init(){
        self.init(shouldReturnError: false)
    }
    
}

enum CustomeError:Error{
    case getError
}

extension NetworkMocking : HttptHandlerProtocol{
    func getRequest(url: inout String, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping ((Error)) -> Void, parameters: [String : Any]?) {
        if(shouldReturnError){
            errorHandler(CustomeError.getError)
        }
        else{
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: mockingData)
                completionHandler(jsonData)
            } catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
