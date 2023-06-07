//
//  NetworkDataFetcher.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 02.06.2023.
//

import Foundation

class NetworkDataFetcher
{
    private var networkService = NetworkService()
    
    func fetchTrack(trackName: String, completion: @escaping (Results?) -> Void) {
        networkService.request(trackName: trackName) { data, error in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: Results.self, from: data)
            completion(decode)
        }
    }
    //Вынести отдельно
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        let str = String(decoding: data, as: UTF8.self)
        do {
            let objects = try decoder.decode(type, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
