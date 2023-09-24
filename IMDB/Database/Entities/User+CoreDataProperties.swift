//
//  User+CoreDataProperties.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?
    @NSManaged public var playlists: NSSet?

}

// MARK: Generated accessors for playlists
extension User {

    @objc(addPlaylistsObject:)
    @NSManaged public func addToPlaylists(_ value: Playlist)

    @objc(removePlaylistsObject:)
    @NSManaged public func removeFromPlaylists(_ value: Playlist)

    @objc(addPlaylists:)
    @NSManaged public func addToPlaylists(_ values: NSSet)

    @objc(removePlaylists:)
    @NSManaged public func removeFromPlaylists(_ values: NSSet)

}

extension User : Identifiable {

}
