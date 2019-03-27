//
//  TMDBEndpoint.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 26/03/2019.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
    var query: String { get }
}

extension Endpoint {
    
    var apiKey: String {
        return "api_key=" + APIConstants.API_KEY
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey + query
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum TMDBServices {

    case upcoming(page: Int)
    case genres
}

extension TMDBServices: Endpoint {
    
    var base: String {
        return APIConstants.TMDB_BASE_URL
    }
    
    var path: String {
        switch self {
        case .upcoming: return "/3/movie/upcoming"
        case .genres: return "/3/genre/movie/list"
        }
    }
    
    var query: String {
        switch self {
        case .upcoming(let page):
            return "&page=\(page)"
        default:
            return ""
        }
    }
}
