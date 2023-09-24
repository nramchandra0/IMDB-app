//
//  MovieListViewModel.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import Foundation

protocol MovieListViewInterface: AnyObject {
    func reloadMoviesTable()
    func reloadCell(at index: Int)
}

class MovieListViewModel {

    // MARK: - Properties

    weak var view: MovieListViewInterface?
    let movieJsonParser = MovieJSONParser()
    var movies: [Movie] = []

    func setupViewModel(view: MovieListViewInterface) {
        self.view = view
        if let movies = DatabaseManager.sharedInstance.getMovies(), movies.count > 0 {
            self.movies = movies
        } else {
            let movieModels = movieJsonParser.getMovies()
            self.movies = DatabaseManager.sharedInstance.saveAllMovies(movieModels) ?? []
        }

        view.reloadMoviesTable()
    }

    func movieCellViewModel(at index: Int) -> MovieCellViewModel {
        .init(movie: movies[index])
    }

    func showFavouriteMovies() {
        self.movies = DatabaseManager.sharedInstance.getMoviesFromPlaylist(withName: "Favorites") ?? []
        view?.reloadMoviesTable()
    }

    func showAllMovies() {
        self.movies = DatabaseManager.sharedInstance.getMovies() ?? []
        view?.reloadMoviesTable()
    }

    func favouriteButtonAction(_ cellVM: MovieCellViewModel) {
        if cellVM.addedToPlaylist {
            DatabaseManager.sharedInstance.removeMovieFromPlaylist(cellVM.movie)
        } else {
            DatabaseManager.sharedInstance.saveMovieToPlaylist(withName: "Favorites", cellVM.movie)
        }
        if let index = movies.firstIndex(of: cellVM.movie) {
            view?.reloadCell(at: index)
        }
    }
}
