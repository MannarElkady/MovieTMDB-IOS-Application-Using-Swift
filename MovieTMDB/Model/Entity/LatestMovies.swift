//
//  LatestMoviesResponse.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//


import Foundation
import RealmSwift

// MARK: - LatestMoviesResponse
struct LatestMoviesResponse: Codable {
    let movies: [Movie]
    let page, totalResults: Int
    let dates: Dates
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}


// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Movie
////this class is used for both json response decoding and as database entity, Note: Object conforms Hashable protocol 
class Movie: Object ,Codable {
    @objc dynamic var popularity: Double
    @objc dynamic var voteCount: Int
    @objc dynamic var video: Bool
    @objc dynamic var posterPath: String?
    @objc dynamic var id: Int
    @objc dynamic var adult: Bool
    @objc dynamic var backdropPath: String?
    @objc dynamic var originalLanguage, originalTitle: String
  //  dynamic let genreIDS: [Int]
    @objc dynamic var title: String
    @objc dynamic var voteAverage: Double
    @objc dynamic var overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
       // case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
 
    override static func primaryKey() -> String? {
        return "id"
    }
}

