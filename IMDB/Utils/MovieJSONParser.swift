//
//  MovieJSONParser.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import Foundation

class MovieJSONParser {

    func getMovies() -> [MovieModel]  {
        guard let jsonFilePath = Bundle.main.path(forResource: "MovieList", ofType: "json") else {
            print("JSON file not found")
            return []
        }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            let response = try JSONDecoder().decode(MovieResult.self, from: jsonData)
            return response.results
        } catch {
            print(error)
        }
        return []
    }
}
