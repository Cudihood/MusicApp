//
//  NetworkService.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 02.06.2023.
//

import Foundation

final class NetworkService
{
    let baseURL = Constants.baseURL
    
    func request(trackName: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let escapedTrackName = trackName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)\(escapedTrackName)") else {
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
                    //
                    //Как тут правильно обрабоать ошибки?
                    switch statusCode {
                    case .success:
                        completion(data, nil)
//                    case .serviceUnavailable:
//                        let error = Message.Error.errorHTTP(statusCode: response.statusCode)
//                        // запрос через алерт
//                        let task = self.createDataTask(from: request, completion: completion)
//                        task.resume()
                    default:
                        let error = Message.Error.errorHTTP(statusCode: response.statusCode)
                        completion(nil, error)
                    }
                //Нужен ли тут else?
                } else {
                    let error = Message.Error.errorInvalidResponse
                    completion(nil, error)
                }
            }
        }
    }
}
