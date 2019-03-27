//
//  UpcomingMoviesTableViewController.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 26/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import UIKit

class UpcomingMoviesTableViewController: UITableViewController {

    // MARK: - Outlets
    
    private let tmdbClient = TMDBClient()
    private var movies: [Movie] = []
    private var currentPage = 1
    private var shouldShowLoadingCell = false
    
    // MARK: - Properties
    
    var genresList: [String] = []
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        
        refreshControl.addTarget(self, action: #selector(reloadMovies), for: .valueChanged)
        
        return refreshControl
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refresher
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovies()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableView.deselectSelectedRow(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = movies.count
        return shouldShowLoadingCell ? count + 1 : count
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingIndexPath(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCellIdentifier", for: indexPath) as! LoadingTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        } else {
            let identifier = String(describing: MovieTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieTableViewCell
            
            let movie = movies[indexPath.row]
            cell.movieViewModel = MovieViewModel(movie: movie)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else {return}
        fetchNextPage()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        let movieDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movieViewModel = MovieViewModel(movie: selectedMovie)
        
        self.present(movieDetailViewController, animated: true)
    }

}

// MARK: - Helpers

extension UpcomingMoviesTableViewController {
    @objc
    private func reloadMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    private func fetchNextPage() {
        currentPage += 1
        loadMovies()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == movies.count
    }
    
    private func loadMovies(refresh: Bool = false) {
        tmdbClient.getUpcomingMovies(at: currentPage){ result in
            switch result {
            case .success(let upcomingMoviesResult):
                guard let upcomingMovies = upcomingMoviesResult?.results else { return }
                
                if refresh {
                    self.movies = upcomingMovies
                    self.refresher.endRefreshing()
                } else {
                    for movie in upcomingMovies {
                        if !self.movies.contains(movie) {
                            self.movies.append(movie)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.shouldShowLoadingCell = upcomingMoviesResult!.page < upcomingMoviesResult!.totalPages
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print("\(error)")
                DispatchQueue.main.async {
                    let reloadAction = UIAlertAction(title: "Reload", style: .default) {
                        action in self.reloadMovies()
                        
                    }
                    let dismissAction = UIAlertAction(title: "Continue", style: .default)
                    let actions = [reloadAction, dismissAction]
                    self.showAlert(with: "Something is wrong", message: "Please try again!", actions: actions)
                }
            }
        }
    }
}
