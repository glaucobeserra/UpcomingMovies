//
//  MovieViewModel.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 26/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import Foundation

final class MovieViewModel: NSObject {
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    var releaseDate: String {
        guard let date = movie.releaseDate else {return "unavailable date"}
        return dateFormat(with: date)
    }
    
    var posterURL: URL {
        let urlString = APIConstants.TMDB_IMAGES_BASE_URL + (movie.posterPath ?? "")
        return URL(string: urlString)!
    }
    
    var backdropURL: URL {
        let urlString = APIConstants.TMDB_IMAGES_BASE_URL + (movie.backdropPath ?? "")
        return URL(string: urlString)!
    }
    
    var voteAverage: String {
        return String(movie.voteAverage)
    }
    
    var movieOverview: String {
        return movie.overview
    }
    
    var limitedGenreList: String {
        return genreStringLimited(with: movie.genreIDs, limit: 2)
    }
    
    var completedGenreList: String {
        return getGenreString(with: movie.genreIDs)
    }
    
    private func dateFormat(with date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = DateHelper.shared.calendar
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: date) else {return "unavailable date"}
        
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    private func genreStringLimited(with genreIDs: [Int], limit: Int) -> String {
        let genreCount = genreIDs.count
        
        if genreCount > limit {
            let genreListID = Array(genreIDs.prefix(limit))
            let difference = genreCount - limit
            return getGenreString(with: genreListID) + " +\(difference)"
        }
        
        return getGenreString(with: genreIDs)
    }
    
    private func getGenreString(with genreIDs: [Int]) -> String {
        let genreList = GenreManager.shared.genreList
        var genresString = ""
        var genreNames: [String] = []
        
        for genreID in genreIDs {
            if let genre = genreList.filter({ $0.id == genreID }).first {
                genreNames.append(genre.name!)
            }
        }
        
        for (index, genre) in genreNames.enumerated() {
            if index != (genreNames.count - 1) {
                genresString += genre + " | "
            } else {
                genresString += genre
            }
        }
        
        return genresString
    }
}
