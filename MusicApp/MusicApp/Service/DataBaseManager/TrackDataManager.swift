//
//  TrackDataManager.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import UIKit
import CoreData
import Kingfisher

final class TrackDataManager
{
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
        let musicTrack = MusicTrack(context: context)
        musicTrack.trackID = Int64(track.trackID ?? 0)
        musicTrack.artistName = track.artistName
        musicTrack.trackName = track.trackName
        musicTrack.artistViewURL = track.artistViewURL
        musicTrack.trackViewURL = track.trackViewURL
        musicTrack.previewURL = track.previewURL
        //Я должен передавать ссылку или картинку????
        fetchImageTrack(urlSting: track.artworkUrl100) { data in
            musicTrack.artwork100 = data
        }
        musicTrack.artworkUrl100 = track.artworkUrl100
        musicTrack.releaseDate = track.releaseDate
        musicTrack.trackTimeMillis = Int64(track.trackTimeMillis ?? 0)
        musicTrack.primaryGenreName = track.primaryGenreName
        
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
                Track(trackID: Int(musicTrack.trackID),
                      artistName: musicTrack.artistName,
                      trackName: musicTrack.trackName,
                      artistViewURL: musicTrack.artistViewURL,
                      trackViewURL: musicTrack.trackViewURL,
                      previewURL: musicTrack.previewURL,
                      artworkUrl60: nil,
                      artworkUrl100: musicTrack.artworkUrl100,
                      releaseDate: musicTrack.releaseDate,
                      trackTimeMillis: Int(musicTrack.trackTimeMillis),
                      primaryGenreName: musicTrack.primaryGenreName,
                      artwork100: musicTrack.artwork100)
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
                print("Track with ID \(id) deleted successfully.")
            } else {
                print("Track with ID \(id) not found.")
            }
        } catch {
            print("Failed to delete track: \(error.localizedDescription)")
        }
    }
    
    func fetchImageTrack(urlSting: String?, completion: @escaping (Data?) -> Void) {
        guard let urlString = urlSting, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let resours = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resours) { result in
            switch result {
            case .success(let imageResult):
                let data = imageResult.image.kf.data(format: .unknown, compressionQuality: 1.0)
                completion(data)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
