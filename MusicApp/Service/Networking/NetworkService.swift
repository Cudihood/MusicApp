//
//  NetworkService.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 02.06.2023.
//

import Foundation

final class NetworkService {
    func request(trackName: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let escapedTrackName = trackName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(Constants.baseURL)\(escapedTrackName)") else {
            let error = Message.Error.errorConverting
            completion(nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    let statusCode = Message.ResponseСode(statusCode: response.statusCode)
                    switch statusCode {
                    case .success:
                        completion(data, nil)
                    default:
                        let error = Message.Error.errorHTTP(statusCode: response.statusCode)
                        completion(nil, error)
                    }
                } else {
                    let error = Message.Error.errorInvalidResponse
                    completion(nil, error)
                }
            }
        }
    }
}

fileprivate extension Constants {
    static let baseURL = "https://itunes.apple.com/search?entity=song&term="
}
