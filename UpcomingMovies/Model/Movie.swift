//
//  Movie.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 22/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    
    let originalTitle: String
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]
    let overview: String
    let releaseDate: String?
    let title: String
    let voteAverage: Double
    
//    var date: String {
//        return releaseDate!.dateFormat()
//    }
    
    var posterURL: String? {
        return "https://image.tmdb.org/t/p/w780" + (posterPath ?? "")
    }
    
    var backdropURL: String? {
        return "https://image.tmdb.org/t/p/original" + (backdropPath ?? "")
    }
    
    private enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        
        case genreIDs = "genre_ids"
        case releaseDate = "release_date"
        
        case overview
        case title
        case voteAverage = "vote_average"
    }
}

struct PagedResponse: Codable {
    
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
