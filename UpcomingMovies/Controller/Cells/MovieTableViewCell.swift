//
//  MovieTableViewCell.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 22/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    var movieViewModel: MovieViewModel! {
        didSet {
            movieNameLabel.text = movieViewModel.movieTitle
            posterImageView.kf.setImage(with: movieViewModel.posterURL, options: [.transition(.fade(0.3))])
            voteAverageLabel.text = movieViewModel.voteAverage
            releaseDateLabel.text = movieViewModel.releaseDate
            genreLabel.text = movieViewModel.limitedGenreList
        }
    }
    
}
