//
//  DatabaseService.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseService {
    
    private var database:Realm
    static let sharedInstance = DatabaseService()

    private init() {
        database = try! Realm()
    }

    func add(movie: Movie){
        try! database.write {
            database.add(movie, update: .modified)
        }
    }
    func addMovieList(movies: [Movie]){
        try! database.write {
            database.add(movies, update: .modified)
        }
    }
    func getAllMovies() -> [Movie] {
        return Array(database.objects(Movie.self))
    }
    func deleteAll(){
        try! database.write {
            database.deleteAll()
        }
    }

    func delete(movie: Movie){
        try! database.write {
            database.delete(movie)
        }

    }

}
