//
//  Playlist+CoreDataProperties.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension Playlist {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension Playlist : Identifiable {

}
