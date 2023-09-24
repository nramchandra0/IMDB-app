//
//  MovieModel.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import Foundation

// MARK: - Movies

struct MovieResult: Codable {
    let results: [MovieModel]
}

// MARK: - Result

struct MovieModel: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}
