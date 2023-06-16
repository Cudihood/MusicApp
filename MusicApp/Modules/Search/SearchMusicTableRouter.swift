//
//  SearchMusicTableRouter.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import Foundation

protocol SearchMusicTableRouterProtocol {
    func goToDetailsScreen(for track: Track)
}

final class SearchMusicTableRouter: BaseRouter, SearchMusicTableRouterProtocol {
    func goToDetailsScreen(for track: Track) {
        let detailVC = DetailViewController.viewController(selectedTrack: track)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
