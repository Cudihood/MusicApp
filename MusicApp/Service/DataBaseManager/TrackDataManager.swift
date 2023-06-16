//
//  TrackDataManager.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import UIKit
import CoreData
import Kingfisher

final class TrackDataManager {
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Не удалось загрузить хранилище данных. Ошибка: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveTrack(track: Track) {
        createMusicTrack(track: track, context: context)
        
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении трека: \(error.localizedDescription)")
        }
    }
    
    func loadTracks() -> [Track]? {
        let request = MusicTrack.fetchRequest()
        do {
            let track = try context.fetch(request)
            let tracksDataArray = track.compactMap { musicTrack in
                Track(musicTrack: musicTrack)
            }
            return tracksDataArray
        } catch let error as NSError {
            print("Не удалось загрузить изображение. Ошибка: \(error)")
            return nil
        }
    }
    
    func deleteTrack(track: Track) {
        guard let id = track.trackID else { return }
        let request: NSFetchRequest<MusicTrack> = MusicTrack.fetchRequest()
        request.predicate = NSPredicate(format: "trackID == %d", id)
        do {
            let tracks = try context.fetch(request)
            if let track = tracks.first {
                context.delete(track)
                try context.save()
            }
        } catch {
            print("Failed to delete track: \(error.localizedDescription)")
        }
    }
    
    func searchTrackByID(trackID: Int) -> Track? {
        let request: NSFetchRequest<MusicTrack> = MusicTrack.fetchRequest()
        request.predicate = NSPredicate(format: "trackID == %d", trackID)
        request.fetchLimit = 1
        do {
            let tracks = try context.fetch(request)
            if let track = tracks.first {
                return Track(musicTrack: track)
            } else {
                return nil
            }
        } catch {
            print("Failed to search track by ID: \(error.localizedDescription)")
            return nil
        }
    }
}

private extension TrackDataManager {
    func createMusicTrack(track: Track, context: NSManagedObjectContext) {
        let musicTrack = MusicTrack(context: context)
        musicTrack.trackID = Int64(track.trackID ?? 0)
        musicTrack.artistName = track.artistName
        musicTrack.trackName = track.trackName
        musicTrack.artistViewURL = track.artistViewURL
        musicTrack.trackViewURL = track.trackViewURL
        musicTrack.previewURL = track.previewURL
        musicTrack.artworkUrl100 = track.artworkUrl100
        musicTrack.releaseDate = track.releaseDate
        musicTrack.trackTimeMillis = Int64(track.trackTimeMillis ?? 0)
        musicTrack.primaryGenreName = track.primaryGenreName
    }
}
