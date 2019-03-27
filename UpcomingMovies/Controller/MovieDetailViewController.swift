//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 25/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var genreListLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    // MARK: - Properties
    var movieViewModel: MovieViewModel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        posterImageView.kf.setImage(with: movieViewModel.posterURL, options: [.transition(.fade(0.3))])
        backdropImageView.kf.setImage(with: movieViewModel.backdropURL, options: [.transition(.fade(0.3))])
        
        posterImageView.kf.indicatorType = .activity
        backdropImageView.kf.indicatorType = .activity
        
        movieTitleLabel.text = movieViewModel.movieTitle
        voteAverageLabel.text = movieViewModel.voteAverage
        genreListLabel.text = movieViewModel.completedGenreList
        
        releaseDateLabel.text = movieViewModel.releaseDate
        overviewTextView.text = movieViewModel.movieOverview
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
