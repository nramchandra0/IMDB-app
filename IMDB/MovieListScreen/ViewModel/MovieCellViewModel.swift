//
//  MovieCellViewModel.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import Foundation

struct MovieCellViewModel {

    let movie: Movie
    let title: String
    let imageURL: String
    let ratingString: String
    let playlistString: String
    var addedToPlaylist: Bool { !playlistString.isEmpty }
    var favouriteImage: String { addedToPlaylist ? "heart.fill" : "heart" }

    init(movie: Movie) {
        self.movie = movie
        title = movie.title ?? ""
        imageURL = "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? "")
        ratingString = "Rating - \(movie.rating)"
        playlistString = movie.playlist?.name ?? ""
    }
}
