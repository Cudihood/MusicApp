//
//  NetworkDataFetcher.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 02.06.2023.
//

import Foundation

final class NetworkDataFetcher
{
    private var networkService = NetworkService()
    
    func fetchTrack(trackName: String, completion: @escaping (Data?, Error?) -> Void) {
        networkService.request(trackName: trackName) { data, error in
            if let error = error {
//                print("Error recieved requesting data: \(error.localizedDescription)")
                completion(nil, error)
            }
            completion(data, nil)
        }
    }
}
