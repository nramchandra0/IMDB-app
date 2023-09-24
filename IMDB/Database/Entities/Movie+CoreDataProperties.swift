//
//  Movie+CoreDataProperties.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//
//

import Foundation
import CoreData

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var movieIdentifier: Int64
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var rating: Double
    @NSManaged public var playlist: Playlist?

}

extension Movie : Identifiable {

}
