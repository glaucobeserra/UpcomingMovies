//
//  GenreManager.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 25/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import Foundation

class GenreManager {
    
    static let shared = GenreManager()
    
    var genreList: [Genre] = []
    
    func loadGenres(){
        TMDBClient().getGenresList { result in
            switch result {
            case .success(let genreListResult):
                guard let genresList = genreListResult?.genres else { return }
                self.genreList = genresList
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
}
