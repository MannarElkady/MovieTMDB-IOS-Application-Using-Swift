//
//  File.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation

////this struct can contain method to parse Array of Objects, if needed  later
struct JsonMapper<T : Codable> {
    func parseObject(jsonData :Data) -> T? {
        var result : T?
        do{
            result = try JSONDecoder().decode(T.self, from: jsonData)
            print(type(of: result))
        }catch{
            print(error)
        }
        return result
    }
}
