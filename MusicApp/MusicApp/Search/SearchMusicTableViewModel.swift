//
//  SearchMusicTableViewModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit

protocol SearchMusicTableViewModelProtocol
{
    var lastSearchedTrackName: String? { get set }
    var tracks: [Track] { get set }
    var tracksUpdateHandler: (() -> Void)? { get set }
    var retryHandler: (() -> Void)? { get set }
    var presentAlertHandler: ((UIAlertController) -> Void)? { get set }
    func fetchTrack(trackName: String)
}

final class SearchMusicTableViewModel: SearchMusicTableViewModelProtocol
{
    var lastSearchedTrackName: String?
    var tracks = [Track]() {
        didSet{
            tracksUpdateHandler?()
        }
    }
    
    var tracksUpdateHandler: (() -> Void)?
    var retryHandler: (() -> Void)?
    var presentAlertHandler: ((UIAlertController) -> Void)?
    
    //Как я должен тут обьявлять алерт???
    private let errorAlert = ErrorAlert()
    
    private let trackRepository: TrackRepositoryProtocol
    
    init(trackRepository: TrackRepositoryProtocol) {
        self.trackRepository = trackRepository
    }
    
    //проверить на корректность опционального разворачивания
    func fetchTrack(trackName: String) {
//        retryHandler
        trackRepository.searchTrack(trackName: trackName) { [weak self] (searchResults, error) in
            guard let self = self else { return }
            
            if let error = error {
                let alert = self.showErrorAlert(error: error)
                self.presentAlertHandler?(alert)
                return
            }
            
            guard let searchResults = searchResults else {
                self.tracks = []
                return
            }
            self.tracks = searchResults.results
        }
    }
    
    func showErrorAlert(error: Error) -> UIAlertController {
//        Как тут передовать значения?
//        errorAlert.retryHandler = {
//            self.retryHandler?()
//        }
        errorAlert.retryHandler = { [weak self] in
            // Вызываем retryHandler для повторного запроса
            guard let trackName = self?.lastSearchedTrackName else {
                return
            }
            self?.fetchTrack(trackName: trackName)
        }
        return errorAlert.createAlert(title: "Ошибка", message: error.localizedDescription)
    }
}
