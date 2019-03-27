//
//  UpcomingMoviesTests.swift
//  UpcomingMoviesTests
//
//  Created by Glauco Dantas Beserra on 26/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class UpcomingMoviesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMovieViewModel() {
        let movie = Movie(originalTitle: "My Movie Test",
                          posterPath: nil,
                          backdropPath: nil,
                          genreIDs: [28,12,16,35,80],
                          overview: "My Overview Test",
                          releaseDate: nil,
                          title: "My title Test",
                          voteAverage: 10.0)
        let movieViewModel = MovieViewModel(movie: movie)
        
        XCTAssertNotNil(movieViewModel.releaseDate)
        XCTAssertEqual(movieViewModel.voteAverage, "10.0")
        XCTAssertNotNil(movieViewModel.posterURL)
        XCTAssertNotNil(movieViewModel.backdropURL)
    }

}
