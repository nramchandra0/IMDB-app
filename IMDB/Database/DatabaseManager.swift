//
//  DatabaseManager.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import UIKit
import CoreData

class DatabaseManager {
    static let sharedInstance = DatabaseManager()
}

extension DatabaseManager {

    func getPlaylsits() -> [Playlist]? {

        guard let user = self.getUser() else {
            return nil
        }

        return user.playlists?.allObjects as? [Playlist]
    }

    func getMovies() -> [Movie]? {

        guard let managedObjectContext = self.getManagedObjectContext() else {
            return nil
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")

        do {
            let movies = try managedObjectContext.fetch(fetchRequest) as? [Movie]

            return movies
        }
        catch let error as NSError {
            print("Get Movies failed \(error) \(error.userInfo)")
        }

        return nil
    }

    func getMoviesFromPlaylist(withName name: String) -> [Movie]? {

        guard let playlist = self.getPlaylist(withName: name) else {
            return nil
        }

        return playlist.movies?.allObjects as? [Movie]
    }
}

extension DatabaseManager {

    func saveAllMovies(_ data: [MovieModel]) -> [Movie]? {

        guard let managedObjectContext = self.getManagedObjectContext() else {
            return nil
        }

        guard let movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
            return nil
        }

        var movies = [Movie]()

        for model in data {

            let movie = Movie(entity: movieEntity, insertInto: managedObjectContext)
            movie.movieIdentifier = Int64(model.id)
            movie.title = model.title
            movie.rating = model.rating
            movie.posterPath = model.posterPath

            movies.append(movie)
        }

        do {
            try managedObjectContext.save()

            return movies
        }
        catch let error as NSError {
            print("Save to Playlist failed \(error) \(error.userInfo)")
        }

        return nil
    }

    @discardableResult
    func saveMovieToPlaylist(withName name: String, _ movie: Movie) -> Bool {

        guard let managedObjectContext = self.getManagedObjectContext() else {
            return false
        }

        guard let playlist = self.getPlaylist(withName: name) else {
            return false
        }

        playlist.addToMovies(movie)

        do {
            try managedObjectContext.save()

            return true
        }
        catch let error as NSError {
            print("Save to Playlist failed \(error) \(error.userInfo)")
        }

        return false
    }

    @discardableResult
    func removeMovieFromPlaylist(_ movie: Movie) -> Bool {

        guard let managedObjectContext = self.getManagedObjectContext() else {
            return false
        }

        movie.playlist = nil

        do {
            try managedObjectContext.save()

            return true
        }
        catch let error as NSError {
            print("Remove from Playlist failed \(error) \(error.userInfo)")
        }

        return false
    }
    
    func createNewPlaylist(withName name: String) -> Playlist? {
        
        guard let managedObjectContext = self.getManagedObjectContext(), let user = self.getUser() else {
            return nil
        }
        
        guard let playlistEntity = NSEntityDescription.entity(forEntityName: "Playlist", in: managedObjectContext) else {
            return nil
        }
        
        let playlist = Playlist(entity: playlistEntity, insertInto: managedObjectContext)
        playlist.name = name
        
        user.addToPlaylists(playlist)
        
        do {
            try managedObjectContext.save()
            
            return playlist
        }
        catch let error as NSError {
            print("Create Playlist failed \(error) \(error.userInfo)")
        }
        
        return nil
    }
}

private extension DatabaseManager {

    func getManagedObjectContext() -> NSManagedObjectContext? {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        return appDelegate.persistentContainer.viewContext
    }

    func getUser() -> User? {

        guard let managedObjectContext = self.getManagedObjectContext() else {
            return nil
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        do {
            let results = try managedObjectContext.fetch(fetchRequest) as? [User]

            if let user = results?.first {
                return user
            }

            return self.createNewUser()
        }
        catch let error as NSError {
            print("Get User failed \(error) \(error.userInfo)")
        }

        return nil
    }

    func getPlaylist(withName name: String) -> Playlist? {

        guard let user = self.getUser() else {
            return nil
        }

        guard let playlists = user.playlists?.allObjects as? [Playlist], playlists.count > 0 else {
            return self.createNewPlaylist(withName: name)
        }

        for playlist in playlists {
            if playlist.name == name {
                return playlist
            }
        }

        return nil
    }
}

private extension DatabaseManager {

    func createNewUser() -> User? {

        guard let managedObjectContext = self.getManagedObjectContext() else {
            return nil
        }

        guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
            return nil
        }

        let user = User(entity: userEntity, insertInto: managedObjectContext)
        user.userName = "MovieLover"

        do {
            try managedObjectContext.save()

            return user
        }
        catch let error as NSError {
            print("Create User failed \(error) \(error.userInfo)")
        }

        return nil
    }
}
