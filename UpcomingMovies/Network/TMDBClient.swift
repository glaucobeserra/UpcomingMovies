//
//  TMDBClient.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 26/03/2019.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import Foundation

class TMDBClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
//    func getFeed(from movieFeedType: TMDBServices, completion: @escaping (Result<PagedResponse?, APIError>) -> Void) {
//        
//        let endpoint = movieFeedType
//        let request = endpoint.request
//        
//        fetch(with: request, decode: { json -> PagedResponse? in
//            guard let movieFeedResult = json as? PagedResponse else { return  nil }
//            return movieFeedResult
//        }, completion: completion)
//    }
    
    func getUpcomingMovies(at page: Int, completion: @escaping (Result<PagedResponse?, APIError>) -> Void) {
        let endpoint = TMDBServices.upcoming(page: page)
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> PagedResponse? in
            guard let upcomingMoviesResult = json as? PagedResponse else { return  nil }
            return upcomingMoviesResult
        }, completion: completion)
    }
    
    func getGenresList(completion: @escaping (Result<GenresList?, APIError>) -> Void) {
        let endpoint = TMDBServices.genres
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> GenresList? in
            guard let genreListResult = json as? GenresList else { return  nil }
            return genreListResult
        }, completion: completion)
    }
}
